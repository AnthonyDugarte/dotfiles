return {
        init_options = {
                provideFormatter = true,
        },
        settings = {
                json = {
                        schemas = require("schemastore").json.schemas(),
                        validate = { enable = true },
                        format = { enable = true }
                },
        },
        capabilities = {
                textDocument = {
                        completion = {
                                completionItem = {
                                        snippetSupport = true
                                }
                        }
                }
        }
}
