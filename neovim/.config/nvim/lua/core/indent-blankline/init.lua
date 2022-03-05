local indent = prequire "indent_blankline"
if not indent then
  return
end

indent.setup {
  space_char_blankline = " ",
  show_current_context = true,
  show_current_context_start = true,
}
