return {
        settings = {
                yaml = {
                        format = {
                                enable = true,
                                printWidth = 4,
                                singleQuote = true,
                        },
                        schemaStore = {
                                enable = false,
                                url = "",
                        },
                        schemas = require('schemastore').yaml.schemas(),

                }
        }
}
