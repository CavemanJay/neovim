vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

-- Set up the 'jj' key mapping to exit insert mode
vim.keymap.set('i', 'jj', '<Esc>', { noremap = true, silent = true })

local formatFn = function()
    vim.lsp.buf.format({ async = true }) -- or use vim.lsp.buf.formatting() for older versions
end
local formatOpts = { noremap = true, silent = false }
-- Set up the 'Shift + Alt + F' key mapping to format the document
vim.keymap.set('n', '<S-A-f>', formatFn, formatOpts)

-- move highlighted lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = false })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = false })

-- keep cursor in place while joining lines
vim.keymap.set("n", "J", "mzJ`z", { silent = false })

-- keep cursor centered when paging up/down
vim.keymap.set("n", "<C-u>", "<C-d>zz", { silent = false })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { silent = false })

-- keep search terms centered
vim.keymap.set("n", "n", "nzzzv", { silent = false })
vim.keymap.set("n", "N", "Nzzzv", { silent = false })

-- paste remap to preserve clipboard when replacing value
vim.keymap.set("x", "<leader>p", "\"_dP", { silent = false })

-- yank to system clipboard
vim.keymap.set("n", "<leader>y", "\"+y", { silent = false })
vim.keymap.set("v", "<leader>y", "\"+y", { silent = false })
vim.keymap.set("n", "<leader>Y", "\"+Y", { silent = false })

-- delete to void register
vim.keymap.set("n", "<leader>d", "\"_d", { silent = false })
vim.keymap.set("v", "<leader>d", "\"_d", { silent = false })

-- quickfix nav
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz", { silent = false })
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz", { silent = false })
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz", { silent = false })
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz", { silent = false })

-- substitute word under cursor
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- make current file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)

vim.keymap.set("n", "<leader>lsp", "<cmd>LspRestart<cr>")

-- Function to display active LSP clients
local function show_lsp_clients()
    local clients = vim.lsp.get_active_clients()
    local messages = {}

    for _, client in ipairs(clients) do
        table.insert(messages, "LSP Client:")
        table.insert(messages, "  Name: " .. client.name)
        table.insert(messages, "  ID: " .. client.id)
        table.insert(messages, "  Filetypes: " .. vim.inspect(client.config.filetypes))
    end

    vim.notify(table.concat(messages, "\n"))
end

vim.keymap.set("n", "<leader>lsc", show_lsp_clients)

-- Set up key mappings for navigating diagnostics
vim.keymap.set('n', '<leader>dn', vim.diagnostic.goto_next, { noremap = true, silent = true, desc = "Go to next diagnostic" })
vim.keymap.set('n', '<leader>dp', vim.diagnostic.goto_prev, { noremap = true, silent = true, desc = "Go to previous diagnostic" })
vim.keymap.set('n', '<leader>df', vim.diagnostic.open_float, { noremap = true, silent = true, desc = "Show diagnostic float" })

-- Function to copy all diagnostics to the quickfix list
local function copy_diagnostics_to_qflist()
    local diagnostics = vim.diagnostic.get(0, { severity = { min = vim.diagnostic.severity.ERROR } })  -- Get all diagnostics
    local qf_list = {}

    for _, diag in ipairs(diagnostics) do
        table.insert(qf_list, {
            bufnr = diag.bufnr,
            lnum = diag.lnum + 1,  -- Neovim uses 0-based line numbers; quickfix list uses 1-based
            col = diag.col + 1,   -- Neovim uses 0-based column numbers; quickfix list uses 1-based
            text = diag.message,
            type = "E",  -- "E" for error; use "W" for warning if needed
        })
    end

    -- Set the quickfix list with the collected diagnostics
    vim.fn.setqflist(qf_list, 'r')
    print("Diagnostics copied to quickfix list")
end

-- Set up a key mapping for the function
vim.keymap.set('n', '<leader>dq', copy_diagnostics_to_qflist, { noremap = true, silent = true, desc = "Copy diagnostics to quickfix list" })

-- directory navigation
require("jay.dir_nav")

-- Visual mode mapping to select all lines
vim.api.nvim_set_keymap('v', 'ae', ':<C-U>normal! ggVG<CR>', { noremap = true, silent = true })

-- Operator-pending mode mapping for 'ae' motion
vim.api.nvim_set_keymap('o', 'ae', ':normal Vae<CR>', { noremap = true, silent = true })
