require("custom")
require("custom.packer")
require("custom.remap")

vim.cmd("colorscheme jellybeans")

local function git_branch()
  return vim.fn["FugitiveHead"]()
end

vim.cmd("set number")
vim.cmd("set relativenumber")

-- silence warnings about using depreated vim APIs
vim.deprecate = function() end

-- Source - https://stackoverflow.com/a
-- Posted by Paul D. Eden, modified by community. See post 'Timeline' for change history
-- Retrieved 2026-01-11, License - CC BY-SA 4.0
-- Remove trailing whitespace on save for all filetypes
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  command = [[%s/\s\+$//e]]
})


_G.git_branch = git_branch

-- Lualine setup
require("lualine").setup({
  options = {
    theme = "jellybeans",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    always_show_tabline = false,
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = {
      {
        "branch",
        source = function()
          return vim.fn["FugitiveHead"]()
        end,
      },
    },
    lualine_c = {
      {
        "filename",
        file_status = true,
        path = 0,
      },
    },
    lualine_x = {
      {
        -- LSP status with diagnostics summary
        function()
          local clients = vim.lsp.get_active_clients({ bufnr = 0 })
          if #clients == 0 then
            return ""
          end

          local diagnostics = vim.diagnostic.get(0)
          local errors = 0
          local warnings = 0
          local hints = 0
          local info = 0

          for _, diagnostic in ipairs(diagnostics) do
            if diagnostic.severity == vim.diagnostic.severity.ERROR then
              errors = errors + 1
            elseif diagnostic.severity == vim.diagnostic.severity.WARN then
              warnings = warnings + 1
            elseif diagnostic.severity == vim.diagnostic.severity.HINT then
              hints = hints + 1
            elseif diagnostic.severity == vim.diagnostic.severity.INFO then
              info = info + 1
            end
          end

          if errors > 0 or warnings > 0 or hints > 0 or info > 0 then
            local parts = {}
            if errors > 0 then
              table.insert(parts, "E:" .. errors)
            end
            if warnings > 0 then
              table.insert(parts, "W:" .. warnings)
            end
            if info > 0 then
              table.insert(parts, "I:" .. info)
            end
            if hints > 0 then
              table.insert(parts, "H:" .. hints)
            end
            return table.concat(parts, " ")
          else
            return "OK"
          end
        end,
        icon = "",
        color = function()
          local diagnostics = vim.diagnostic.get(0)
          local has_errors = false
          local has_warnings = false

          for _, diagnostic in ipairs(diagnostics) do
            if diagnostic.severity == vim.diagnostic.severity.ERROR then
              has_errors = true
            elseif diagnostic.severity == vim.diagnostic.severity.WARN then
              has_warnings = true
            end
          end

          if has_errors then
            return { fg = "#ff6c6b" } -- red
          elseif has_warnings then
            return { fg = "#ECBE7B" } -- yellow
          else
            return { fg = "#98be65" } -- green for OK
          end
        end,
      },
      "encoding",
      "fileformat",
      "filetype",
    },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {
    lualine_a = {
      {
        "buffers",
        show_filename_only = true,
        hide_filename_extension = false,
        show_modified_status = true,
        mode = 0, -- 0: Shows buffer name, 1: Shows buffer index, 2: Shows buffer name + index
        max_length = vim.o.columns * 2 / 3,
        filetype_names = {
          TelescopePrompt = "Telescope",
          dashboard = "Dashboard",
          packer = "Packer",
          fzf = "FZF",
        },
        buffers_color = {
          active = "lualine_a_normal",
          inactive = "lualine_a_inactive",
        },
      },
    },
    lualine_z = { "tabs" },
  },
})


-- Register custom jet treesitter parser only on machines where the source repo is cloned.
if vim.fn.isdirectory("/home/james/streemit/jet/inlet") == 1 then
  local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
  parser_config.jet = {
    install_info = {
      url = "/home/james/streemit/jet/inlet/",
      files = { "src/parser.c" },
    },
    filetype = "jet",
  }
end
