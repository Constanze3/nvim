return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio"
    },
    config = function() 
        local dap = require("dap")

        dap.adapters.lldb = {
            type = "server",
            port = "${port}",
            executable = {
                command = "codelldb",
                args = { "--port", "${port}" }
            },
            detached = vim.loop.os_uname().sysname ~= "Windows"
        }

        dap.configurations.rust = {
            {
                name = "Debug Executable",
                type = "lldb",
                request = "launch",
                program = function() 
                    local root = vim.fs.root(0, "Cargo.toml")
                    if root == nil then
                        error("Not a Cargo project")
                    end

                    local program_name = vim.fn.fnamemodify(root, ":t")
                    return root .. "/target/debug/" .. program_name .. ".exe" 
                end,
                cwd = '${workspaceFolder}',
                stopOnEntry = false
            }
        }

        local dapui = require("dapui")
        dapui.setup({})

        dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open({})
        end
    end
}