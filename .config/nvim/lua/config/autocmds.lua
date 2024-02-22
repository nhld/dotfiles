vim.api.nvim_create_autocmd({ "TermOpen" }, {
	callback = function()
		vim.wo.number = false
		vim.wo.relativenumber = false
		vim.wo.spell = false
		vim.cmd("startinsert")
	end,
})
