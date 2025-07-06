return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "nvim-neotest/nvim-nio",
    },
    config = function()
        local dap = require("dap")

        dap.adapters.lldb = {
            type = "server",
            port = "${port}",
            executable = {
                command = "codelldb",
                args = { "--port", "${port}" },
            },
            detached = vim.loop.os_uname().sysname ~= "Windows",
        }

        dap.adapters.python = {
            type = "executable",
            command = "python",
            args = { "-m", "debugpy.adapter" },
            options = {
                source_filetype = "python",
            },
        }

        dap.adapters.dart = {
            type = "executable",
            command = "dart",
            args = { "debug_adapter" },
            options = {
                detached = vim.loop.os_uname().sysname ~= "Windows",
            },
        }

        dap.adapters.flutter = {
            type = "executable",
            command = "flutter",
            args = { "debug_adapter" },
            options = {
                detached = vim.loop.os_uname().sysname ~= "Windows",
            },
        }

        dap.configurations.rust = {
            {
                name = "Debug executable",
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
                cwd = "${workspaceFolder}",
                stopOnEntry = false,
            },
        }

        dap.configurations.python = {
            {
                name = "Debug file",
                type = "python",
                request = "launch",
                program = "${file}",
                console = "integratedTerminal",
            },
        }

        dap.configurations.dart = {
            {
                name = "Launch dart",
                type = "dart",
                request = "launch",
                program = "${workspaceFolder}/lib/main.dart",
                cwd = "${workspaceFolder}",
            },
            {
                name = "Launch flutter",
                type = "flutter",
                request = "launch",
                program = "${workspaceFolder}/lib/main.dart",
                cwd = "${workspaceFolder}",
            },
        }
    end,
}
