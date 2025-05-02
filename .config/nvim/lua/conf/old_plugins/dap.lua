local js_based_languages = {
        "typescript",
        "javascript",
        "typescriptreact",
        "javascriptreact",
        "vue",
}


return {
        {
                "mfussenegger/nvim-dap",
                keys = {
                        { "<leader>d",  "",                                                                                   desc = "+debug",              mode = { "n", "v" } },
                        { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
                        { "<leader>db", function() require("dap").toggle_breakpoint() end,                                    desc = "Toggle Breakpoint" },
                        { "<leader>dc", function() require("dap").continue() end,                                             desc = "Run/Continue" },
                        {
                                "<leader>da",
                                function()
                                        if vim.fn.filereadable(".vscode/launch.json") then
                                                local dap_vscode = require("dap.ext.vscode")
                                                dap_vscode.load_launchjs(nil, {
                                                        ["pwa-node"] = js_based_languages,
                                                        ["chrome"] = js_based_languages,
                                                        ["pwa-chrome"] = js_based_languages,
                                                })
                                        end

                                        require("dap").continue({ before = get_args })
                                end,
                                desc = "Run with Args",
                        },
                        { "<leader>dC", function() require("dap").run_to_cursor() end,    desc = "Run to Cursor" },
                        { "<leader>dg", function() require("dap").goto_() end,            desc = "Go to Line (No Execute)" },
                        { "<leader>di", function() require("dap").step_into() end,        desc = "Step Into" },
                        { "<leader>dj", function() require("dap").down() end,             desc = "Down" },
                        { "<leader>dk", function() require("dap").up() end,               desc = "Up" },
                        { "<leader>dl", function() require("dap").run_last() end,         desc = "Run Last" },
                        { "<leader>do", function() require("dap").step_out() end,         desc = "Step Out" },
                        { "<leader>dO", function() require("dap").step_over() end,        desc = "Step Over" },
                        { "<leader>dp", function() require("dap").pause() end,            desc = "Pause" },
                        { "<leader>dr", function() require("dap").repl.toggle() end,      desc = "Toggle REPL" },
                        { "<leader>ds", function() require("dap").session() end,          desc = "Session" },
                        { "<leader>dt", function() require("dap").terminate() end,        desc = "Terminate" },
                        { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
                },

                config = function()
                        require('dap.ext.vscode').json_decode = require 'json5'.parse

                        local dap = require("dap")

                        dap.defaults.fallback.external_terminal = {
                                command = '/opt/homebrew/bin/kitty',
                                args = { '-e' },
                        }

                        for _, language in ipairs(js_based_languages) do
                                dap.configurations[language] = {
                                        -- Debug single nodejs files
                                        {
                                                type = "pwa-node",
                                                request = "launch",
                                                name = "Launch file",
                                                program = "${file}",
                                                cwd = "${workspaceFolder}",
                                        },
                                        {
                                                type = "pwa-node",
                                                request = "launch",
                                                name = "Launch file - Nodemon",
                                                runtimeExecutable = "nodemon",
                                                program = "${file}",
                                                cwd = "${workspaceFolder}",
                                        },
                                        -- Debug nodejs processes (make sure to add --inspect when you run the process)
                                        {
                                                type = "pwa-node",
                                                request = "attach",
                                                name = "Attach",
                                                processId = require("dap.utils").pick_process,
                                                cwd = "${workspaceFolder}",
                                        },
                                        -- Debug web applications (client side)
                                        {
                                                type = "pwa-chrome",
                                                request = "launch",
                                                name = "Launch & Debug Chrome",
                                                url = function()
                                                        local co = coroutine.running()
                                                        return coroutine.create(function()
                                                                vim.ui.input({
                                                                        prompt = "Enter URL: ",
                                                                        default = "http://localhost:3000",
                                                                }, function(url)
                                                                        if url == nil or url == "" then
                                                                                return
                                                                        else
                                                                                coroutine.resume(co, url)
                                                                        end
                                                                end)
                                                        end)
                                                end,
                                                webRoot = "${workspaceFolder}",
                                                protocol = "inspector",
                                                userDataDir = false,
                                        },
                                }
                        end
                end,
                dependencies = {
                        "theHamsta/nvim-dap-virtual-text",
                        {
                                "Joakker/lua-json5",
                                build = "./install.sh",
                        },
                        {
                                "mxsdev/nvim-dap-vscode-js",
                                dependencies = {
                                        {
                                                "microsoft/vscode-js-debug",
                                                -- After install, build it and rename the dist directory to out
                                                build =
                                                "npm install --legacy-peer-deps --no-save && npx gulp vsDebugServerBundle && rm -rf out && mv dist out",
                                                version = "1.*",
                                        },
                                },
                                config = function()
                                        require("dap-vscode-js").setup({
                                                debugger_path = vim.fn.resolve(vim.fn.stdpath("data") ..
                                                        "/lazy/vscode-js-debug"),
                                                adapters = {
                                                        "chrome",
                                                        "pwa-node",
                                                        "pwa-chrome",
                                                        "pwa-msedge",
                                                        "pwa-extensionHost",
                                                        "node-terminal",
                                                },
                                        })
                                end,
                        },
                },
        },
        {
                "rcarriga/nvim-dap-ui",
                dependencies = {
                        "mfussenegger/nvim-dap",
                        "nvim-neotest/nvim-nio",
                },
                opts = {},
                keys = {
                        { "<leader>du", function() require("dapui").toggle({}) end, desc = "Dap UI" },
                        { "<leader>de", function() require("dapui").eval() end,     desc = "Eval",  mode = { "n", "v" } },
                },
                config = function(_, opts)
                        local dap, dapui = require("dap"), require("dapui")


                        dapui.setup(opts)

                        dap.listeners.before.attach.dapui_config = function()
                                dapui.open()
                        end
                        dap.listeners.before.launch.dapui_config = function()
                                dapui.open()
                        end
                        dap.listeners.before.event_terminated.dapui_config = function()
                                dapui.close()
                        end
                        dap.listeners.before.event_exited.dapui_config = function()
                                dapui.close()
                        end
                end
        },
}
