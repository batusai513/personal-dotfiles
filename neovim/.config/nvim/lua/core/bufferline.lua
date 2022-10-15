local bufferline = prequire "bufferline"
local M = {}

if not bufferline then
  return
end

local function is_ft(b, ft)
  return vim.bo[b].filetype == ft
end

local function diagnostics_indicator(_, _, diagnostics)
  local result = {}
  local symbols = { error = "", warning = "", info = "" }
  for name, count in pairs(diagnostics) do
    if symbols[name] and count > 0 then
      table.insert(result, symbols[name] .. count)
    end
  end
  result = table.concat(result, " ")
  return #result > 0 and result or ""
end

local function custom_filter(buf, buf_nums)
  local logs = vim.tbl_filter(function(b)
    return is_ft(b, "log")
  end, buf_nums)
  if vim.tbl_isempty(logs) then
    return true
  end

  local tab_num = vim.fn.tabpagenr()
  local last_tab = vim.fn.tabpagenr "$"
  local is_log = is_ft(buf, "log")
  if last_tab == 1 then
    return true
  end
  -- only show log buffers in secondary tabs
  return (tab_num == last_tab and is_log) or (tab_num ~= last_tab and not is_log)
end

local options = {
  numbers = "none", -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
  close_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
  right_mouse_command = "vert sbuffer %d", -- can be a string | function, see "Mouse actions"
  left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
  middle_mouse_command = nil, -- can be a string | function, see "Mouse actions"
  max_name_length = 18,
  max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
  tab_size = 18,
  diagnostics = "nvim_lsp",
  diagnostics_update_in_insert = false,
  diagnostics_indicator = diagnostics_indicator,
  -- NOTE: this will be called a lot so don't do any heavy processing here
  custom_filter = custom_filter,
  offsets = {
    {
      filetype = "undotree",
      text = "Undotree",
      highlight = "PanelHeading",
      padding = 1,
    },
    {
      filetype = "NvimTree",
      text = "Explorer",
      highlight = "PanelHeading",
      padding = 1,
    },
    {
      filetype = "DiffviewFiles",
      text = "Diff View",
      highlight = "PanelHeading",
      padding = 1,
    },
    {
      filetype = "flutterToolsOutline",
      text = "Flutter Outline",
      highlight = "PanelHeading",
    },
    {
      filetype = "packer",
      text = "Packer",
      highlight = "PanelHeading",
      padding = 1,
    },
  },
  show_buffer_icons = true,
  show_buffer_close_icons = true,
  show_close_icon = true,
  show_tab_indicators = true,
  persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
  -- can also be a table containing 2 custom separators
  -- [focused and unfocused]. eg: { '|', '|' }
  separator_style = "thin", -- | "thick" | "thin" | { 'any', 'any' },
  enforce_regular_tabs = true,
  always_show_bufferline = false,
  sort_by = "id",
}

local highlights = {
  background = {
    italic = true,
  },
  buffer_selected = {
    bold = true,
  },
}

bufferline.setup {
  options = options,
  highlights = highlights,
}

-- Common kill function for bdelete and bwipeout
-- credits: based on bbye and nvim-bufdel
---@param kill_command string defaults to "bd"
---@param bufnr number defaults to the current buffer
---@param force boolean defaults to false
function M.buf_kill(kill_command, bufnr, force)
  local bo = vim.bo
  local api = vim.api

  if bufnr == 0 or bufnr == nil then
    bufnr = api.nvim_get_current_buf()
  end

  kill_command = kill_command or "bd"

  -- If buffer is modified and force isn't true, print error and abort
  if not force and bo[bufnr].modified then
    return api.nvim_err_writeln(
      string.format("No write since last change for buffer %d (set force to true to override)", bufnr)
    )
  end

  -- Get list of windows IDs with the buffer to close
  local windows = vim.tbl_filter(function(win)
    return api.nvim_win_get_buf(win) == bufnr
  end, api.nvim_list_wins())

  if #windows == 0 then
    return
  end

  if force then
    kill_command = kill_command .. "!"
  end

  -- Get list of active buffers
  local buffers = vim.tbl_filter(function(buf)
    return api.nvim_buf_is_valid(buf) and bo[buf].buflisted
  end, api.nvim_list_bufs())

  -- If there is only one buffer (which has to be the current one), vim will
  -- create a new buffer on :bd.
  -- For more than one buffer, pick the previous buffer (wrapping around if necessary)
  if #buffers > 1 then
    for i, v in ipairs(buffers) do
      if v == bufnr then
        local prev_buf_idx = i == 1 and (#buffers - 1) or (i - 1)
        local prev_buffer = buffers[prev_buf_idx]
        for _, win in ipairs(windows) do
          api.nvim_win_set_buf(win, prev_buffer)
        end
      end
    end
  end

  -- Check if buffer still exists, to ensure the target buffer wasn't killed
  -- due to options like bufhidden=wipe.
  if api.nvim_buf_is_valid(bufnr) and bo[bufnr].buflisted then
    vim.cmd(string.format("%s %d", kill_command, bufnr))
  end
end

return M
