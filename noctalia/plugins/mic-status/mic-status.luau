--!nonstrict

local muted = false
local capturing = false
local captureApps = {}

local captureColor =
    noctalia.getConfig("capture_color") or "#D7AF87"

local mutedColor =
    noctalia.getConfig("muted_color") or "tertiary"

local activityColor =
    noctalia.getConfig("activity_color") or "#8DB881"

local appBlacklist =
    noctalia.getConfig("app_blacklist") or {}

local refreshInFlight = false
local refreshPending = false


--
-- Voice activity / pulse configuration
--
-- These are deliberately constants for now while we tune the behaviour.
--

local micLevel = 0
local micPeak = 0

-- Ignore tiny values around the microphone noise floor.
local pulseNoiseFloor = 10

-- Our testing showed normal/loud speech reaching roughly 20–50.
local pulseFullScale = 25

-- React quickly when speech begins.
local pulseAttack = 0.70

-- Fade back more slowly when speech stops.
local pulseRelease = 0.45


local function normalizeAppName(value)
    if type(value) ~= "string" then
        return ""
    end

    local trimmed =
        string.gsub(value, "^%s*(.-)%s*$", "%1")

    return string.lower(trimmed)
end


local function isBlacklisted(app)
    local normalizedApp =
        normalizeAppName(app)

    if normalizedApp == "" then
        return false
    end

    for _, blockedApp in ipairs(appBlacklist) do
        if
            normalizedApp
            == normalizeAppName(blockedApp)
        then
            return true
        end
    end

    return false
end


local function isInternalCaptureApp(app)
    local normalizedApp =
        normalizeAppName(app)

    --
    -- CAVA opens the microphone itself so it can analyse
    -- the signal.
    --
    -- It must never cause the privacy indicator to enter
    -- capture state by itself.
    --
    return normalizedApp == "cava"
end


local function shouldIgnoreCaptureApp(app)
    return
        isInternalCaptureApp(app)
        or isBlacklisted(app)
end


--
-- Colour helpers
--

local function parseHexColor(value)
    if type(value) ~= "string" then
        return nil
    end

    local r, g, b =
        string.match(
            value,
            "^#(%x%x)(%x%x)(%x%x)$"
        )

    if r == nil then
        return nil
    end

    return
        tonumber(r, 16),
        tonumber(g, 16),
        tonumber(b, 16)
end


local function interpolateColor(fromColor, toColor, amount)
    local fr, fg, fb = parseHexColor(fromColor)
    local tr, tg, tb = parseHexColor(toColor)

    if fr == nil or tr == nil then
        return fromColor
    end

    amount = math.max(0, math.min(amount, 1))

    local r =
        math.floor(fr + (tr - fr) * amount + 0.5)

    local g =
        math.floor(fg + (tg - fg) * amount + 0.5)

    local b =
        math.floor(fb + (tb - fb) * amount + 0.5)

    return string.format("#%02X%02X%02X", r, g, b)
end

local function pulseColor(level)
    return interpolateColor(
        captureColor,
        activityColor,
        level
    )
end


local function updateCapturePulse()
    if not capturing or muted then
        return
    end

    barWidget.setGlyphColor(
        pulseColor(micLevel)
    )
end


local function updateTooltip()
    local rows = {}

    if capturing then
        local apps =
            "Unknown application"

        if #captureApps > 0 then
            apps =
                table.concat(
                    captureApps,
                    ", "
                )
        end

        table.insert(rows, {
            key = "Microphone",
            value = apps,
        })
    end

    if muted then
        table.insert(rows, {
            key = "State",
            value = "Muted",
        })
    end

    if #rows > 0 then
        barWidget.setTooltip(rows)
    else
        barWidget.clearTooltip()
    end
end


local function render()
    noctalia.log(
        "render: muted="
            .. tostring(muted)
            .. " capturing="
            .. tostring(capturing)
    )

    if muted then
        micLevel = 0
        micPeak = 0

        barWidget.setVisible(true)
        barWidget.setGlyph(
            "microphone-off"
        )
        barWidget.setGlyphColor(
            mutedColor
        )

    elseif capturing then
        barWidget.setVisible(true)
        barWidget.setGlyph(
            "microphone-filled"
        )

        --
        -- Start from the configured base capture colour.
        -- The next CAVA frame will update it if sound is
        -- currently present.
        --
        barWidget.setGlyphColor(
            pulseColor(micLevel)
        )

    else
        micLevel = 0
        micPeak = 0

        barWidget.setVisible(false)
    end

    updateTooltip()
end


local function refresh()
    if refreshInFlight then
        refreshPending = true
        return
    end

    refreshInFlight = true

    local command = [=[
        export LC_ALL=C

        printf 'MUTE='
        pactl get-source-mute @DEFAULT_SOURCE@ 2>/dev/null

        pactl list short source-outputs 2>/dev/null | awk '
            NF { count++ }
            END {
                print "CAPTURE_COUNT=" count + 0
            }
        '

        pactl list source-outputs 2>/dev/null | awk '
            function clean(value) {
                sub(/^[^=]*= "/, "", value)
                sub(/"$/, "", value)
                return value
            }

            function emit() {
                if (!have_output)
                    return

                if (app != "")
                    print "APP=" app
                else if (binary != "")
                    print "APP=" binary
                else if (media != "")
                    print "APP=" media
                else if (node != "")
                    print "APP=" node
                else
                    print "APP="
            }

            /^Source Output #[0-9]+/ {
                emit()

                have_output = 1
                app = ""
                binary = ""
                media = ""
                node = ""
                next
            }

            /^[[:space:]]*application.name = / {
                app = clean($0)
                next
            }

            /^[[:space:]]*application.process.binary = / {
                binary = clean($0)
                next
            }

            /^[[:space:]]*media.name = / {
                media = clean($0)
                next
            }

            /^[[:space:]]*node.name = / {
                node = clean($0)
                next
            }

            END {
                emit()
            }
        '
    ]=]

    noctalia.runAsync(
        command,
        function(result)
            refreshInFlight = false

            noctalia.log(
                "pactl exit="
                    .. tostring(result.exitCode)
                    .. " stdout="
                    .. result.stdout
            )

            local output =
                result.stdout or ""

            muted =
                string.find(
                    output,
                    "MUTE=Mute: yes",
                    1,
                    true
                ) ~= nil

            local captureCount = 0
            local allApps = {}

            for line in string.gmatch(
                output,
                "[^\r\n]+"
            ) do
                local count =
                    string.match(
                        line,
                        "^CAPTURE_COUNT=(%d+)$"
                    )

                if count ~= nil then
                    captureCount =
                        tonumber(count) or 0
                end

                local app =
                    string.match(
                        line,
                        "^APP=(.+)$"
                    )

                if
                    app ~= nil
                    and app ~= ""
                then
                    table.insert(
                        allApps,
                        app
                    )
                end
            end

            local apps = {}
            local seen = {}

            for _, app in ipairs(allApps) do
                if
                    not shouldIgnoreCaptureApp(app)
                    and not seen[app]
                then
                    seen[app] = true

                    table.insert(
                        apps,
                        app
                    )
                end
            end

            captureApps = apps

            --
            -- Remove CAVA and user-blacklisted streams
            -- from the effective capture count.
            --
            local ignoredCaptureCount = 0

            for _, app in ipairs(allApps) do
                if shouldIgnoreCaptureApp(app) then
                    ignoredCaptureCount =
                        ignoredCaptureCount + 1
                end
            end

            local effectiveCaptureCount =
                math.max(
                    0,
                    captureCount
                        - ignoredCaptureCount
                )

            --
            -- Normally each source-output has an
            -- application.name.
            --
            -- If one doesn't, retain the original privacy
            -- behaviour and treat it as an unknown capture.
            --
            local unknownCaptureCount =
                math.max(
                    0,
                    captureCount
                        - #allApps
                )

            capturing =
                effectiveCaptureCount > 0
                and (
                    #captureApps > 0
                    or unknownCaptureCount > 0
                )

            render()

            if refreshPending then
                refreshPending = false
                refresh()
            end
        end,
        1500
    )
end


--
-- CAVA
--

local function parseCavaFrame(line)
    local values = {}

    for raw in string.gmatch(
        line or "",
        "([^;]+)"
    ) do
        local value =
            tonumber(raw)

        if value == nil then
            return nil
        end

        table.insert(
            values,
            value
        )
    end

    if #values == 0 then
        return nil
    end

    return values
end


local function calculateTargetLevel(values)
    local peak = 0

    for _, value in ipairs(values) do
        if value > peak then
            peak = value
        end
    end

    if peak <= pulseNoiseFloor then
        return peak, 0
    end

    local level =
        (peak - pulseNoiseFloor)
        / (
            pulseFullScale
            - pulseNoiseFloor
        )

    level =
        math.max(
            0,
            math.min(level, 1)
        )

    --
    -- A square-root response gives quieter speech more
    -- visible movement while still preserving the upper
    -- dynamic range.
    --
    level =
        math.sqrt(level)

    return peak, level
end


local function smoothMicLevel(target)
    local factor

    if target > micLevel then
        factor = pulseAttack
    else
        factor = pulseRelease
    end

    micLevel =
        micLevel
        + (target - micLevel)
            * factor

    --
    -- Snap very small residual values back to zero so
    -- the colour eventually returns exactly to its base.
    --
    if micLevel < 0.005 then
        micLevel = 0
    end
end


local function onCavaLine(line)
    local source =
        string.match(
            line,
            "^__MIC_STATUS_CAVA_SOURCE__=(.+)$"
        )

    if source ~= nil then
        noctalia.log(
            "cava: microphone source="
                .. tostring(source)
        )

        return
    end

    local errorMessage =
        string.match(
            line,
            "^__MIC_STATUS_CAVA_ERROR__=(.+)$"
        )

    if errorMessage ~= nil then
        noctalia.log(
            "cava: error="
                .. tostring(errorMessage)
        )

        return
    end

    local values =
        parseCavaFrame(line)

    if values == nil then
        --
        -- Ignore non-frame CAVA output rather than trying
        -- to interpret it as an audio level.
        --
        return
    end

    --
    -- Voice visualisation is only meaningful while a real,
    -- non-blacklisted application is capturing.
    --
    if not capturing or muted then
        micLevel = 0
        micPeak = 0
        return
    end

    local targetLevel

    micPeak, targetLevel =
        calculateTargetLevel(values)

    smoothMicLevel(
        targetLevel
    )

    updateCapturePulse()
end


local function startCava()
    local command = [=[
        export LC_ALL=C

        if ! command -v cava >/dev/null 2>&1; then
            printf '__MIC_STATUS_CAVA_ERROR__=cava not found\n'
            exit 1
        fi

        if ! command -v wpctl >/dev/null 2>&1; then
            printf '__MIC_STATUS_CAVA_ERROR__=wpctl not found\n'
            exit 1
        fi

        MIC_SERIAL="$(
            wpctl inspect @DEFAULT_AUDIO_SOURCE@ 2>/dev/null |
            sed -n 's/.*object.serial = "\([^"]*\)".*/\1/p' |
            head -n 1
        )"

        if [ -z "$MIC_SERIAL" ]; then
            printf '__MIC_STATUS_CAVA_ERROR__=could not resolve default microphone\n'
            exit 1
        fi

        printf '__MIC_STATUS_CAVA_SOURCE__=%s\n' "$MIC_SERIAL"

        exec cava -p /dev/stdin 2>&1 <<EOF
[general]
framerate = 20
bars = 4
autosens = 1

[input]
method = pipewire
source = $MIC_SERIAL
active = 1
remix = 1
virtual = 1

[output]
method = raw
raw_target = /dev/stdout
data_format = ascii
ascii_max_range = 100
bar_delimiter = 59
frame_delimiter = 10
channels = mono
mono_option = average
EOF
    ]=]

    local started =
        noctalia.runStream(
            command,
            onCavaLine
        )

    if not started then
        noctalia.log(
            "cava: failed to start stream"
        )
    end
end


--
-- Startup
--

barWidget.setVisible(false)

refresh()

startCava()


noctalia.runStream(
    "LC_ALL=C pactl subscribe",
    function(line)
        local sourceEvent =
            string.find(
                line,
                "source",
                1,
                true
            ) ~= nil

        local serverEvent =
            string.find(
                line,
                "server",
                1,
                true
            ) ~= nil

        if sourceEvent or serverEvent then
            refresh()
        end
    end
)


function onClick()
    noctalia.runAsync(
        "noctalia msg mic-mute"
    )
end
