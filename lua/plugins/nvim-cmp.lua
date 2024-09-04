return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
  },
  opts = function(_, opts)
    vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
    local has_words_before = function()
      unpack = unpack or table.unpack
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end

    local cmp = require("cmp")
    cmp.setup({
      sources = {
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "path" },
      },
    })

    local has_action = function(action)
      return cmp.get_active_entry() and cmp.get_active_entry().source.name == action
    end

    table.insert(opts.sources, 1, {
      name = "nvim_lsp",
      entry_filter = function(entry, _)
        return require("cmp.types").lsp.CompletionItemKind[entry:get_kind()] ~= "Text"
      end,
    })
    opts.mapping = vim.tbl_extend("force", opts.mapping, {
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item({ select = true })
        elseif has_words_before() and has_action("nvim_lsp") then
          cmp.complete()
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        else
          fallback()
        end
      end, { "i", "s" }),
    })
  end,
}
