-- Initialize the directory stack
local dir_stack = {}

-- Push the current directory onto the stack
local function push_dir()
    table.insert(dir_stack, vim.fn.getcwd())
    local new_dir = vim.fn.expand('%:p:h')
    local x = vim.fn.fnameescape(new_dir)
    vim.cmd('cd ' .. x)
    print('pushed directory to ' .. x)
end

-- Pop the directory off the stack
local function pop_dir()
     if #dir_stack == 0 then
        print("Directory stack is empty")
        return
    end
    local prev_dir = table.remove(dir_stack)
    local x = vim.fn.fnameescape(prev_dir)
    vim.cmd('cd ' .. x)
    print('popped directory to ' .. x)
end

-- Map the functions to convenient keys
vim.keymap.set('n', "<leader>pd", push_dir,{ noremap = true, silent = false })
vim.keymap.set('n', '<leader>pop', pop_dir, { noremap = true, silent = false })


-- change dir to current file for current window
vim.keymap.set('n', '<leader>cd', ":lcd %:p:h<cr>", { noremap = true, silent = false })
vim.keymap.set('n', '<leader>cD', ":lcd -<cr>", { noremap = true, silent = false })

vim.api.nvim_create_user_command('DirStack', function()
  print(vim.inspect(dir_stack))
end, {})
