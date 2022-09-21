local icons = require "core.theme.icons"

local cmp = prequire "cmp"
if not cmp then
  return
end

local luasnip = prequire "luasnip"
if not luasnip then
  vim.notify "LuaSnip not loaded"
  return
end

require("luasnip/loaders/from_vscode").lazy_load()

--   פּ ﯟ   some other good icons
local kind_icons = icons.kind
-- find more here: https://www.nerdfonts.com/cheat-sheet

local confirm_opts = {
  behavior = cmp.ConfirmBehavior.Replace,
  select = false,
}

local options = {
  confirm_opts = confirm_opts,
  completion = {
    completeopt = "menu,menuone,noinsert",
    keyword_length = 1,
  },
  experimental = {
    ghost_text = true,
  },
  view = {
    entries = "custom",
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<C-e>"] = cmp.mapping {
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    },
    ["<CR>"] = cmp.mapping.confirm { select = true },
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.jumpable(1) then
        luasnip.jump(1)
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif luasnip.expandable() then
        luasnip.expand()
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
  },
  formatting = {
    -- fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
      -- Kind icons
      -- vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
      vim_item.kind = (kind_icons[vim_item.kind] or "") .. " " .. vim_item.kind
      vim_item.menu = ({
        nvim_lsp = "[LSP]",
        luasnip = "[Snip]",
        buffer = "[Buf]",
        path = "[Path]",
      })[entry.source.name]
      return vim_item
    end,
  },
  sources = cmp.config.sources {
    { name = "nvim_lsp", max_item_count = 10 },
    { name = "luasnip" },
    { name = "buffer", max_item_count = 5 },
    { name = "path" },
  },
  window = {
    documentation = {
      border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    },
  },
}

options = require("core.utils").load_override(options, "hrsh7th/nvim-cmp")

cmp.setup(options)

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline("/", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" },
  },
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
  formatting = {
    fields = { "kind", "abbr" },
    format = function(entry, vim_item)
      vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
      return vim_item
    end,
  },
  mapping = cmp.mapping.preset.cmdline {
    ["<CR>"] = cmp.mapping(
      cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      },
      { "i", "c" }
    ),
  },
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
})
