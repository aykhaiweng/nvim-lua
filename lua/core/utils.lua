local M = {}

function M.dump(o)
	if type(o) == "table" then
		local s = "{ "
		for k, v in pairs(o) do
			if type(k) ~= "number" then
				k = '"' .. k .. '"'
			end
			s = s .. "[" .. k .. "] = " .. M.dump(v) .. ","
		end
		return s .. "} "
	else
		return tostring(o)
	end
end

--- Project level file ignores
local standard_defaults = { ".git", "node_modules", ".cache" }

---@param keys table A list of keys to extract from .nvim.lua
function M.get_project_excludes(keys)
	local final_excludes = vim.deepcopy(standard_defaults)
	local local_config_path = vim.fn.getcwd() .. "/.nvim.lua"

	if vim.fn.filereadable(local_config_path) == 1 then
		-- Load the file chunk without executing it yet
		local chunk = loadfile(local_config_path)

		if chunk then
			-- Create an isolated environment to capture variables
			local env = {}
			-- Optional: Allow the local config to still access global Neovim APIs if needed
			setmetatable(env, { __index = _G })

			-- Assign the environment to the loaded chunk (Lua 5.1 / LuaJIT syntax)
			setfenv(chunk, env)

			-- Execute the code safely
			local ok = pcall(chunk)

			-- Check if successful and if our target variable 'project_ignores' exists
			if ok and type(env.project_ignores) == "table" then
				local i = env.project_ignores

				-- Merge global list
				if type(i.global) == "table" then
					vim.list_extend(final_excludes, i.global)
				end

				-- Merge specific keys dynamically
				for _, key in ipairs(keys) do
					if type(i[key]) == "table" then
						vim.list_extend(final_excludes, i[key])
					end
				end
			end
		end
	end

	return final_excludes
end

return M
