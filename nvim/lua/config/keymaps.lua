-- Loaded by LazyVim on the VeryLazy event.
-- Handle both Cmd+V and the Ctrl+V produced by Ghostty's modifier remapping.
local function paste_from_clipboard()
  local text = vim.fn.getreg("+")
  if text ~= "" then
    vim.api.nvim_paste(text, true, -1)
  end
end

for _, key in ipairs({ "<D-v>", "<C-v>" }) do
  vim.keymap.set({ "n", "i", "x", "s", "c" }, key, paste_from_clipboard, {
    desc = "Paste from system clipboard",
  })
end
