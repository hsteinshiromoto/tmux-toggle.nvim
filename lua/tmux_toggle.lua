local M = {}

-- Function to toggle tmux pane
function M.toggle_pane()
	local tmux = "tmux"
	local get_pane_cmd = tmux .. " show -wqv @myspecialpane"
	local pane_id = vim.fn.system(get_pane_cmd):gsub("\n", "")

	if pane_id ~= "" then
		-- Check if pane exists
		local list_panes_cmd = tmux .. " lsp -F'#{pane_id}'"
		local pane_exists = vim.fn.system(list_panes_cmd):find("^" .. pane_id)

		if pane_exists then
			-- Kill the pane and unset the variable
			os.execute(tmux .. " killp -t" .. pane_id)
			os.execute(tmux .. " set -wu @myspecialpane")
			print("Pane closed")
		else
			print("Pane does not exist")
		end
	else
		-- Create a new pane and set the variable
		local split_pane_cmd = tmux .. " splitw -PF'#{pane_id}'"
		local new_pane_id = vim.fn.system(split_pane_cmd):gsub("\n", "")
		os.execute(tmux .. " set -w @myspecialpane " .. new_pane_id)
		print("Pane created: " .. new_pane_id)
	end
end

return M
