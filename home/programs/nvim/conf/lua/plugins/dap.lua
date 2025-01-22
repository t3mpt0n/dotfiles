return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"mfussenegger/nvim-dap-python",
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
		},
		config = function()
			local dap, dapui, wk = require("dap"), require("dapui"), require("which-key")
			local b4_dap = dap.listeners.before
			local adap = dap.adapters
			local dapconf = dap.configurations
			adap.lldb = {
				type = "executable",
				command = "/run/current-system/sw/bin/lldb-dap",
				name = "lldb",
			}
			dapconf.rust = {
				{
					-- Taken from here: https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#ccrust-via-lldb-vscode
					name = "Launch",
					type = "lldb",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
					args = {},
					initCommands = function()
						-- Find out where to look for the pretty printer Python module
						local rustc_sysroot = vim.fn.trim(vim.fn.system("rustc --print sysroot"))

						local script_import = 'command script import "'
							.. rustc_sysroot
							.. '/run/current-system/sw/lib/rustlib/etc/lldb_lookup.py"'
						local commands_file = rustc_sysroot .. "/run/current-system/sw/lib/rustlib/etc/lldb_commands"

						local commands = {}
						local file = io.open(commands_file, "r")
						if file then
							for line in file:lines() do
								table.insert(commands, line)
							end
							file:close()
						end
						table.insert(commands, 1, script_import)

						return commands
					end,
					-- 💀
					-- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
					--
					--    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
					--
					-- Otherwise you might get the following error:
					--
					--    Error on launch: Failed to attach to the target process
					--
					-- But you should be aware of the implications:
					-- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
					-- runInTerminal = false,
				},
				{
					-- Taken from here: https://github.com/mfussenegger/nvim-dap/wiki/Cookbook#pick-a-process

					-- If you get an "Operation not permitted" error using this, try disabling YAMA:
					--  echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
					name = "Attach to process",
					type = "rust", -- Adjust this to match your adapter name (`dap.adapters.<name>`)
					request = "attach",
					pid = require("dap.utils").pick_process,
					args = {},
				},
			}
			b4_dap.attach.dapui_config = function()
				dapui.open()
			end
			b4_dap.launch.dapui_config = function()
				dapui.open()
			end
			b4_dap.event_terminated.dapui_config = function()
				dapui.close()
			end
			b4_dap.event_exited.dapui_config = function()
				dapui.close()
			end
			wk.add({
				{ "<leader>d", group = "DAP" },
				{
					"<leader>dt",
					function()
						dap.toggle.breakpoint()
					end,
				},
				{
					"<leader>dc",
					function()
						dap.toggle.continue()
					end,
				},
			})
		end,
	},
}
