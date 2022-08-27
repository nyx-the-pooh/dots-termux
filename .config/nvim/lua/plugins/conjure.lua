-- Setup for Chicken Scheme
vim.api.nvim_set_var('conjure#client#scheme#stdio#command', 'csi -quiet -:c')
vim.api.nvim_set_var('conjure#client#scheme#stdio#prompt_pattern', '\n-#;%d-> ')
