return {
  {
    "rmagatti/auto-session",
    config = function()
      require("auto-session").setup({
        log_level = "error",
        auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
        auto_session_enable_last_session = false,
        -- Specify the session directory
        auto_session_root_dir = vim.fn.expand("~/.local/share/nvim/sessions/"),
        -- Optional: Configure session name
        -- auto_session_filename_template = "last-session.vim",
      })
    end,
  },
}
