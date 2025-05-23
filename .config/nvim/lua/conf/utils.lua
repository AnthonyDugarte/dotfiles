local M = {}

function M.is_helm_file(path)
        local check = vim.fs.find("Chart.yaml", { path = vim.fs.dirname(path), upward = true })
        return not vim.tbl_isempty(check)
end

--@private
--@return string
function M.yaml_filetype(path, bufname)
        return M.is_helm_file(path) and "helm.yaml" or "yaml"
end

--@private
--@return string
function M.tmpl_filetype(path, bufname)
        return M.is_helm_file(path) and "helm.tmpl" or "template"
end

--@private
--@return string
function M.tpl_filetype(path, bufname)
        return M.is_helm_file(path) and "helm.tmpl" or "smarty"
end

function M.get_selection()
        return vim.fn.getregion(
                vim.fn.getpos ".", vim.fn.getpos "v", { mode = vim.fn.mode() }
        )
end

return M
