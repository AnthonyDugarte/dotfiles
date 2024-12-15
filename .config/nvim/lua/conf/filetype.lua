local utils = require("conf.utils")

vim.filetype.add({
        extension = {
                yaml = utils.yaml_filetype,
                yml  = utils.yaml_filetype,
                tmpl = utils.tmpl_filetype,
                tpl  = utils.tpl_filetype
        },
        filename = {
                ["Chart.yaml"] = "yaml",
                ["Chart.lock"] = "yaml",
        }
})
