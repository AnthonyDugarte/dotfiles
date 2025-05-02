return {
        root_dir = function(bufnr, on_dir)
                local dir = require('lspconfig.util').root_pattern(
                        'angular.json',
                        'nx.json'
                )(vim.fn.bufname(bufnr))

                if dir then
                        on_dir(dir)
                end
        end

}
