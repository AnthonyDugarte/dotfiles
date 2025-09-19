return {
        {
                "nvim-neorg/neorg",
                lazy = false,
                version = "*",
                enabled = false,
                opts = {
                        load = {
                                ["core.defaults"] = {},
                                ["core.dirman"] = {
                                        config = {
                                                workspaces = {
                                                        notes = "~/notes",
                                                },
                                        },
                                },
                        },
                }
        }
}
