--!nonstrict

local muted = false
local capturing = false
local captureApps = {}

local captureColor = noctalia.getConfig("capture_color") or "tertiary"
local mutedColor = noctalia.getConfig("muted_color") or "error"

local refreshInFlight = false
local refreshPending = false


local function updateTooltip()
    local rows = {}

    if capturing then
        local apps = "Unknown application"

        if #captureApps > 0 then
            apps = table.concat(captureApps, ", ")
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
        barWidget.setVisible(true)
        barWidget.setGlyph("microphone-off")
        barWidget.setGlyphColor(mutedColor)

    elseif capturing then
        barWidget.setVisible(true)
        barWidget.setGlyph("microphone")
        barWidget.setGlyphColor(captureColor)

    else
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

        if [ -n "$(pactl list short source-outputs 2>/dev/null)" ]; then
            printf 'CAPTURE=1\n'
        else
            printf 'CAPTURE=0\n'
        fi

        pactl list source-outputs 2>/dev/null | awk '
            /^[[:space:]]*application.name = / {
                value = $0
                sub(/^[^=]*= "/, "", value)
                sub(/"$/, "", value)
                print "APP=" value
            }
        '
    ]=]

    noctalia.runAsync(command, function(result)
        refreshInFlight = false

        noctalia.log(
            "pactl exit="
                .. tostring(result.exitCode)
                .. " stdout="
                .. result.stdout
        )

        local output = result.stdout or ""

        muted =
            string.find(output, "MUTE=Mute: yes", 1, true) ~= nil

        capturing =
            string.find(output, "CAPTURE=1", 1, true) ~= nil

        local apps = {}
        local seen = {}

        for line in string.gmatch(output, "[^\r\n]+") do
            local app = string.match(line, "^APP=(.+)$")

            if app ~= nil and app ~= "" and not seen[app] then
                seen[app] = true
                table.insert(apps, app)
            end
        end

        captureApps = apps

        render()

        if refreshPending then
            refreshPending = false
            refresh()
        end
    end, 1500)
end


barWidget.setVisible(false)

refresh()


noctalia.runStream("LC_ALL=C pactl subscribe", function(line)
    local sourceEvent =
        string.find(line, "source", 1, true) ~= nil

    local serverEvent =
        string.find(line, "server", 1, true) ~= nil

    if sourceEvent or serverEvent then
        refresh()
    end
end)


function onClick()
    noctalia.runAsync("noctalia msg mic-mute")
end
