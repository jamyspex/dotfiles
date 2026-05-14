-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

local time
local profile_info
local should_profile = false
if should_profile then
  local hrtime = vim.loop.hrtime
  profile_info = {}
  time = function(chunk, start)
    if start then
      profile_info[chunk] = hrtime()
    else
      profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
    end
  end
else
  time = function(chunk, start) end
end

local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/james/.cache/nvim/packer_hererocks/2.1.1741730670/share/lua/5.1/?.lua;/home/james/.cache/nvim/packer_hererocks/2.1.1741730670/share/lua/5.1/?/init.lua;/home/james/.cache/nvim/packer_hererocks/2.1.1741730670/lib/luarocks/rocks-5.1/?.lua;/home/james/.cache/nvim/packer_hererocks/2.1.1741730670/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/james/.cache/nvim/packer_hererocks/2.1.1741730670/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["blink.cmp"] = {
    config = { "\27LJ\2\ná\3\0\0\5\0\18\0\0216\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0=\3\a\0025\3\t\0005\4\b\0=\4\n\3=\3\v\0025\3\r\0005\4\f\0=\4\14\3=\3\15\0025\3\16\0=\3\17\2B\0\2\1K\0\1\0\nfuzzy\1\0\1\19implementation\29prefer_rust_with_warning\fsources\fdefault\1\0\1\fdefault\0\1\5\0\0\blsp\tpath\rsnippets\vbuffer\15completion\18documentation\1\0\1\18documentation\0\1\0\1\14auto_show\1\15appearance\1\0\1\22nerd_font_variant\tmono\vkeymap\1\0\5\vkeymap\0\nfuzzy\0\15appearance\0\fsources\0\15completion\0\1\0\1\vpreset\fdefault\nsetup\14blink.cmp\frequire\0" },
    loaded = true,
    path = "/home/james/.local/share/nvim/site/pack/packer/start/blink.cmp",
    url = "https://github.com/saghen/blink.cmp"
  },
  ["conform.nvim"] = {
    config = { "\27LJ\2\n‚\2\0\0\6\0\16\0\0196\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\b\0005\3\6\0005\4\3\0005\5\4\0=\5\5\4=\4\a\3=\3\t\0025\3\v\0005\4\n\0=\4\f\3=\3\r\0025\3\14\0=\3\15\2B\0\2\1K\0\1\0\19format_on_save\1\0\2\17lsp_fallback\2\15timeout_ms\3Ù\3\21formatters_by_ft\blua\1\0\1\blua\0\1\2\0\0\vstylua\15formatters\1\0\3\19format_on_save\0\21formatters_by_ft\0\15formatters\0\vstylua\1\0\1\vstylua\0\16append_args\1\5\0\0\18--indent-type\vSpaces\19--indent-width\0062\1\0\2\fcommand\vstylua\16append_args\0\nsetup\fconform\frequire\0" },
    loaded = true,
    path = "/home/james/.local/share/nvim/site/pack/packer/start/conform.nvim",
    url = "https://github.com/stevearc/conform.nvim"
  },
  ["copilot.vim"] = {
    loaded = true,
    path = "/home/james/.local/share/nvim/site/pack/packer/start/copilot.vim",
    url = "https://github.com/github/copilot.vim"
  },
  ["friendly-snippets"] = {
    loaded = true,
    path = "/home/james/.local/share/nvim/site/pack/packer/start/friendly-snippets",
    url = "https://github.com/rafamadriz/friendly-snippets"
  },
  fzf = {
    loaded = true,
    path = "/home/james/.local/share/nvim/site/pack/packer/start/fzf",
    url = "https://github.com/junegunn/fzf"
  },
  ["fzf.vim"] = {
    loaded = true,
    path = "/home/james/.local/share/nvim/site/pack/packer/start/fzf.vim",
    url = "https://github.com/junegunn/fzf.vim"
  },
  ["jellybeans.vim"] = {
    loaded = true,
    path = "/home/james/.local/share/nvim/site/pack/packer/start/jellybeans.vim",
    url = "https://github.com/nanotech/jellybeans.vim"
  },
  ["lualine.nvim"] = {
    loaded = true,
    path = "/home/james/.local/share/nvim/site/pack/packer/start/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["mason-lspconfig.nvim"] = {
    after = { "nvim-lspconfig" },
    config = { "\27LJ\2\n†\1\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\21ensure_installed\1\0\2\21ensure_installed\0\27automatic_installation\2\1\3\0\0\vlua_ls\18rust_analyzer\nsetup\20mason-lspconfig\frequire\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/home/james/.local/share/nvim/site/pack/packer/opt/mason-lspconfig.nvim",
    url = "https://github.com/williamboman/mason-lspconfig.nvim"
  },
  ["mason.nvim"] = {
    after = { "mason-lspconfig.nvim" },
    config = { "\27LJ\2\n7\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\nmason\frequire\0" },
    loaded = true,
    only_config = true,
    path = "/home/james/.local/share/nvim/site/pack/packer/start/mason.nvim",
    url = "https://github.com/williamboman/mason.nvim"
  },
  ["nvim-lspconfig"] = {
    after = { "rust-tools.nvim" },
    config = { "\27LJ\2\nO\0\1\5\2\3\0\b-\1\0\0008\1\0\0019\1\0\0015\3\1\0-\4\1\0=\4\2\3B\1\2\1K\0\1\0\0¿\1¿\17capabilities\1\0\1\17capabilities\0\nsetupÒ\2\0\2\t\0\18\0:5\2\0\0=\1\1\0026\3\2\0009\3\3\0039\3\4\3'\5\5\0'\6\6\0006\a\2\0009\a\a\a9\a\b\a9\a\t\a\18\b\2\0B\3\5\0016\3\2\0009\3\3\0039\3\4\3'\5\5\0'\6\n\0006\a\2\0009\a\a\a9\a\b\a9\a\v\a\18\b\2\0B\3\5\0016\3\2\0009\3\3\0039\3\4\3'\5\5\0'\6\f\0006\a\2\0009\a\a\a9\a\b\a9\a\r\a\18\b\2\0B\3\5\0016\3\2\0009\3\3\0039\3\4\3'\5\5\0'\6\14\0006\a\2\0009\a\a\a9\a\b\a9\a\15\a\18\b\2\0B\3\5\0016\3\2\0009\3\3\0039\3\4\3'\5\5\0'\6\16\0006\a\2\0009\a\a\a9\a\b\a9\a\17\a\18\b\2\0B\3\5\1K\0\1\0\vformat\14<leader>f\vrename\15<leader>rn\16code_action\15<leader>ca\nhover\6K\15definition\bbuf\blsp\agd\6n\bset\vkeymap\bvim\vbuffer\1\0\2\vbuffer\0\nremap\1õ\2\1\0\6\2\14\0\18-\0\0\0009\0\0\0009\0\1\0005\2\2\0-\3\1\0=\3\3\0025\3\t\0005\4\5\0005\5\4\0=\5\6\0045\5\a\0=\5\b\4=\4\n\3=\3\v\0023\3\f\0=\3\r\2B\0\2\1K\0\1\0\0¿\1¿\14on_attach\0\rsettings\18rust-analyzer\1\0\1\18rust-analyzer\0\14procMacro\1\0\1\venable\2\ncargo\1\0\3\16checkOnSave\2\ncargo\0\14procMacro\0\1\0\1\16allFeatures\2\17capabilities\1\0\3\rsettings\0\14on_attach\0\17capabilities\0\nsetup\18rust_analyzer¿\1\1\0\6\0\n\0\0206\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0029\1\3\1B\1\1\0026\2\0\0'\4\4\0B\2\2\0029\2\5\0025\4\b\0003\5\6\0>\5\1\0043\5\a\0=\5\t\4B\2\2\0012\0\0ÄK\0\1\0\18rust_analyzer\1\0\1\18rust_analyzer\0\0\0\nsetup\20mason-lspconfig\25get_lsp_capabilities\14blink.cmp\14lspconfig\frequire\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/home/james/.local/share/nvim/site/pack/packer/opt/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\2\nó\1\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\14highlight\1\0\1\14highlight\0\1\0\2&additional_vim_regex_highlighting\1\venable\2\nsetup\28nvim-treesitter.configs\frequire\0" },
    loaded = true,
    path = "/home/james/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-web-devicons"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/james/.local/share/nvim/site/pack/packer/opt/nvim-web-devicons",
    url = "https://github.com/nvim-tree/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/james/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/james/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["rust-tools.nvim"] = {
    config = { "\27LJ\2\n£\2\0\0\b\0\15\0\0216\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\r\0005\4\5\0006\5\0\0'\a\3\0B\5\2\0029\5\4\5B\5\1\2=\5\6\0045\5\n\0005\6\b\0005\a\a\0=\a\t\6=\6\v\5=\5\f\4=\4\14\3B\1\2\1K\0\1\0\vserver\1\0\1\vserver\0\rsettings\18rust-analyzer\1\0\1\18rust-analyzer\0\ncargo\1\0\2\ncargo\0\16checkOnSave\2\1\0\1\16allFeatures\2\17capabilities\1\0\2\rsettings\0\17capabilities\0\25get_lsp_capabilities\14blink.cmp\nsetup\15rust-tools\frequire\0" },
    load_after = {},
    loaded = true,
    needs_bufread = true,
    path = "/home/james/.local/share/nvim/site/pack/packer/opt/rust-tools.nvim",
    url = "https://github.com/simrat39/rust-tools.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/home/james/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["tiny-inline-diagnostic.nvim"] = {
    config = { "\27LJ\2\n–\1\0\0\5\0\f\0\0166\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0005\3\4\0005\4\3\0=\4\5\3=\3\a\2B\0\2\0016\0\b\0009\0\t\0009\0\n\0005\2\v\0B\0\2\1K\0\1\0\1\0\1\17virtual_text\1\vconfig\15diagnostic\bvim\foptions\1\0\1\foptions\0\15virt_texts\1\0\1\15virt_texts\0\1\0\1\rpriority\3èN\nsetup\27tiny-inline-diagnostic\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/james/.local/share/nvim/site/pack/packer/opt/tiny-inline-diagnostic.nvim",
    url = "https://github.com/rachartier/tiny-inline-diagnostic.nvim"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/home/james/.local/share/nvim/site/pack/packer/start/vim-fugitive",
    url = "https://github.com/tpope/vim-fugitive"
  },
  ["vim-tmux-clipboard"] = {
    loaded = true,
    path = "/home/james/.local/share/nvim/site/pack/packer/start/vim-tmux-clipboard",
    url = "https://github.com/roxma/vim-tmux-clipboard"
  },
  ["vim-tmux-focus-events"] = {
    loaded = true,
    path = "/home/james/.local/share/nvim/site/pack/packer/start/vim-tmux-focus-events",
    url = "https://github.com/tmux-plugins/vim-tmux-focus-events"
  },
  ["vim-tmux-navigator"] = {
    loaded = true,
    path = "/home/james/.local/share/nvim/site/pack/packer/start/vim-tmux-navigator",
    url = "https://github.com/christoomey/vim-tmux-navigator"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
try_loadstring("\27LJ\2\nó\1\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\14highlight\1\0\1\14highlight\0\1\0\2&additional_vim_regex_highlighting\1\venable\2\nsetup\28nvim-treesitter.configs\frequire\0", "config", "nvim-treesitter")
time([[Config for nvim-treesitter]], false)
-- Config for: conform.nvim
time([[Config for conform.nvim]], true)
try_loadstring("\27LJ\2\n‚\2\0\0\6\0\16\0\0196\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\b\0005\3\6\0005\4\3\0005\5\4\0=\5\5\4=\4\a\3=\3\t\0025\3\v\0005\4\n\0=\4\f\3=\3\r\0025\3\14\0=\3\15\2B\0\2\1K\0\1\0\19format_on_save\1\0\2\17lsp_fallback\2\15timeout_ms\3Ù\3\21formatters_by_ft\blua\1\0\1\blua\0\1\2\0\0\vstylua\15formatters\1\0\3\19format_on_save\0\21formatters_by_ft\0\15formatters\0\vstylua\1\0\1\vstylua\0\16append_args\1\5\0\0\18--indent-type\vSpaces\19--indent-width\0062\1\0\2\fcommand\vstylua\16append_args\0\nsetup\fconform\frequire\0", "config", "conform.nvim")
time([[Config for conform.nvim]], false)
-- Config for: blink.cmp
time([[Config for blink.cmp]], true)
try_loadstring("\27LJ\2\ná\3\0\0\5\0\18\0\0216\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0=\3\a\0025\3\t\0005\4\b\0=\4\n\3=\3\v\0025\3\r\0005\4\f\0=\4\14\3=\3\15\0025\3\16\0=\3\17\2B\0\2\1K\0\1\0\nfuzzy\1\0\1\19implementation\29prefer_rust_with_warning\fsources\fdefault\1\0\1\fdefault\0\1\5\0\0\blsp\tpath\rsnippets\vbuffer\15completion\18documentation\1\0\1\18documentation\0\1\0\1\14auto_show\1\15appearance\1\0\1\22nerd_font_variant\tmono\vkeymap\1\0\5\vkeymap\0\nfuzzy\0\15appearance\0\fsources\0\15completion\0\1\0\1\vpreset\fdefault\nsetup\14blink.cmp\frequire\0", "config", "blink.cmp")
time([[Config for blink.cmp]], false)
-- Config for: mason.nvim
time([[Config for mason.nvim]], true)
try_loadstring("\27LJ\2\n7\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\nmason\frequire\0", "config", "mason.nvim")
time([[Config for mason.nvim]], false)
-- Load plugins in order defined by `after`
time([[Sequenced loading]], true)
vim.cmd [[ packadd mason-lspconfig.nvim ]]

-- Config for: mason-lspconfig.nvim
try_loadstring("\27LJ\2\n†\1\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\21ensure_installed\1\0\2\21ensure_installed\0\27automatic_installation\2\1\3\0\0\vlua_ls\18rust_analyzer\nsetup\20mason-lspconfig\frequire\0", "config", "mason-lspconfig.nvim")

vim.cmd [[ packadd nvim-lspconfig ]]

-- Config for: nvim-lspconfig
try_loadstring("\27LJ\2\nO\0\1\5\2\3\0\b-\1\0\0008\1\0\0019\1\0\0015\3\1\0-\4\1\0=\4\2\3B\1\2\1K\0\1\0\0¿\1¿\17capabilities\1\0\1\17capabilities\0\nsetupÒ\2\0\2\t\0\18\0:5\2\0\0=\1\1\0026\3\2\0009\3\3\0039\3\4\3'\5\5\0'\6\6\0006\a\2\0009\a\a\a9\a\b\a9\a\t\a\18\b\2\0B\3\5\0016\3\2\0009\3\3\0039\3\4\3'\5\5\0'\6\n\0006\a\2\0009\a\a\a9\a\b\a9\a\v\a\18\b\2\0B\3\5\0016\3\2\0009\3\3\0039\3\4\3'\5\5\0'\6\f\0006\a\2\0009\a\a\a9\a\b\a9\a\r\a\18\b\2\0B\3\5\0016\3\2\0009\3\3\0039\3\4\3'\5\5\0'\6\14\0006\a\2\0009\a\a\a9\a\b\a9\a\15\a\18\b\2\0B\3\5\0016\3\2\0009\3\3\0039\3\4\3'\5\5\0'\6\16\0006\a\2\0009\a\a\a9\a\b\a9\a\17\a\18\b\2\0B\3\5\1K\0\1\0\vformat\14<leader>f\vrename\15<leader>rn\16code_action\15<leader>ca\nhover\6K\15definition\bbuf\blsp\agd\6n\bset\vkeymap\bvim\vbuffer\1\0\2\vbuffer\0\nremap\1õ\2\1\0\6\2\14\0\18-\0\0\0009\0\0\0009\0\1\0005\2\2\0-\3\1\0=\3\3\0025\3\t\0005\4\5\0005\5\4\0=\5\6\0045\5\a\0=\5\b\4=\4\n\3=\3\v\0023\3\f\0=\3\r\2B\0\2\1K\0\1\0\0¿\1¿\14on_attach\0\rsettings\18rust-analyzer\1\0\1\18rust-analyzer\0\14procMacro\1\0\1\venable\2\ncargo\1\0\3\16checkOnSave\2\ncargo\0\14procMacro\0\1\0\1\16allFeatures\2\17capabilities\1\0\3\rsettings\0\14on_attach\0\17capabilities\0\nsetup\18rust_analyzer¿\1\1\0\6\0\n\0\0206\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0029\1\3\1B\1\1\0026\2\0\0'\4\4\0B\2\2\0029\2\5\0025\4\b\0003\5\6\0>\5\1\0043\5\a\0=\5\t\4B\2\2\0012\0\0ÄK\0\1\0\18rust_analyzer\1\0\1\18rust_analyzer\0\0\0\nsetup\20mason-lspconfig\25get_lsp_capabilities\14blink.cmp\14lspconfig\frequire\0", "config", "nvim-lspconfig")

vim.cmd [[ packadd rust-tools.nvim ]]

-- Config for: rust-tools.nvim
try_loadstring("\27LJ\2\n£\2\0\0\b\0\15\0\0216\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\r\0005\4\5\0006\5\0\0'\a\3\0B\5\2\0029\5\4\5B\5\1\2=\5\6\0045\5\n\0005\6\b\0005\a\a\0=\a\t\6=\6\v\5=\5\f\4=\4\14\3B\1\2\1K\0\1\0\vserver\1\0\1\vserver\0\rsettings\18rust-analyzer\1\0\1\18rust-analyzer\0\ncargo\1\0\2\ncargo\0\16checkOnSave\2\1\0\1\16allFeatures\2\17capabilities\1\0\2\rsettings\0\17capabilities\0\25get_lsp_capabilities\14blink.cmp\nsetup\15rust-tools\frequire\0", "config", "rust-tools.nvim")

time([[Sequenced loading]], false)
vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au LspAttach * ++once lua require("packer.load")({'tiny-inline-diagnostic.nvim'}, { event = "LspAttach *" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
