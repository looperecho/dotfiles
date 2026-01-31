-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local uv = vim.uv or vim.loop

if not uv.fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"

  -- Avoid partial clone here: it can leave you with a broken checkout ("promisor remote")
  local out = vim.fn.system({
    "git", "clone",
    "--branch=stable",
    lazyrepo,
    lazypath,
  })

  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)

-- Call lazy
require("lazy").setup("plugins", {
  -- Make installs resilient to intermittent DNS / network hiccups
  git = {
    filter = false,  -- disable partial clones (prevents promisor-remote checkout failures)
  },
  concurrency = 4,   -- reduce parallel git operations; try 2 if still flaky
})
