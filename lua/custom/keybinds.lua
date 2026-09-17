-- vim.keymap.set({'n','v'},'<leader>arn','*Ncgn',{desc = '[A]ction [R]eplace word and move to [N]ext'})
local function replace_motion_and_next(_)
  vim.cmd 'normal! `[v`]y'
  vim.api.nvim_feedkeys('q/p' .. vim.api.nvim_replace_termcodes('<CR>', true, false, true) .. 'Ncgn', 'n', false)
end

vim.keymap.set('n', '<leader>arn', function()
  vim.op.operatorfunc = replace_motion_and_next -- vim.op, not vim.o
  return 'g@'
end, { expr = true, desc = '[A]ction [R]eplace word and move to [N]ext' })
