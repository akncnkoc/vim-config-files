return {
  {
    "editorconfig/editorconfig-vim",
    config = function()
      -- Optional configuration settings
      vim.g.EditorConfig_exclude_patterns = { "fugitive://.*", "scp://.*" }
    end,
  },
}
