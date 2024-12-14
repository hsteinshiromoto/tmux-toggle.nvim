local tmux_toggle = require("tmux_toggle")

-- Create a Neovim command to toggle the pane
vim.api.nvim_create_user_command("TmuxTogglePane", tmux_toggle.toggle_pane, { desc = "Toggle a tmux pane" })
