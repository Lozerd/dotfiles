local M = {}

M.tox_config_dir = function()
    local dir = vim.fn.getcwd() .. "/tox.ini"
    if vim.fn.filereadable(dir) then
        return dir
    else
        return nil
    end
end

return M
