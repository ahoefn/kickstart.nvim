
require 'utils'
vim.pack.add {
  'https://github.com/nvim-lua/plenary.nvim',
 { src = Gh 'ThePrimeagen/harpoon', version = 'harpoon2' }
}
local harpoon = require 'harpoon'

harpoon.setup()

vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end, {desc = "[H]arpoon [A]dd"})
vim.keymap.set("n", "<leader>hl", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, {desc = "[H]arpoon [L]ist"})

vim.keymap.set("n", "<leader>hq", function() harpoon:list():select(1) end, {desc = "[H]arpoon to [Q]"})
vim.keymap.set("n", "<leader>hw", function() harpoon:list():select(2) end, {desc = "[H]arpoon to [W]"})
vim.keymap.set("n", "<leader>he", function() harpoon:list():select(3) end, {desc = "[H]arpoon to [E]"})
vim.keymap.set("n", "<leader>hr", function() harpoon:list():select(4) end, {desc = "[H]arpoon to [R]"})

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<leader>hp", function() harpoon:list():prev() end, {desc = "[H]arpoon [P]revious"})
vim.keymap.set("n", "<leader>hn", function() harpoon:list():next() end, {desc = "[H]arpoon [N]ext"})

-- basic telescope configuration
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
    end

    require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
            results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
    }):find()
end

vim.keymap.set("n", "<leader>hv", function() toggle_telescope(harpoon:list()) end,
    { desc = "[H]arpoon [V]iew" })
