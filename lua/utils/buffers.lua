local M = {}

M.close_buffers_by_filetype = function(filetype)
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.bo[buf].filetype == filetype then
			vim.api.nvim_command("bdelete " .. buf)
		end
	end
end

return M
