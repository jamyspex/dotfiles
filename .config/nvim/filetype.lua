vim.filetype.add({
  extension = {
    jet = "jet",
  },
  filename = {
    -- If you have specific filenames that should be treated as jet files
    -- ['Jetfile'] = 'jet',
  },
  pattern = {
    -- If you want to detect based on file patterns
    [".*%.jet"] = "jet",
  },
})
