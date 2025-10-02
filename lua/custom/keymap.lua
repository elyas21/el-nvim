-- Create a small module to hold our state and functions
local JkToggle = {}

-- This variable will hold the state of our mapping.
-- true = enabled, false = disabled.
-- Set the default state you prefer when you start Neovim.
JkToggle.is_enabled = true

-- Function to ENABLE the jk mapping
function JkToggle.enable()
  vim.keymap.set('i', 'jk', '<Esc>', { desc = 'Escape Insert Mode' })
  JkToggle.is_enabled = true
  -- Give user feedback that the mapping is now on
  vim.notify("jk -> <Esc> mapping ENABLED", vim.log.levels.INFO, { title = "Keymap Toggle" })
end

-- Function to DISABLE the jk mapping
function JkToggle.disable()
  vim.keymap.del('i', 'jk')
  JkToggle.is_enabled = false
  -- Give user feedback that the mapping is now off
  vim.notify("jk -> <Esc> mapping DISABLED", vim.log.levels.WARN, { title = "Keymap Toggle" })
end

-- The main TOGGLE function
function JkToggle.toggle()
  if JkToggle.is_enabled then
    JkToggle.disable()
  else
    JkToggle.enable()
  end
end

-- === Set up the triggers for the user ===

-- 1. Create a user command so you can type `:ToggleJkMap`
vim.api.nvim_create_user_command(
  'ToggleJkMap',
  JkToggle.toggle,
  { desc = 'Enable or disable the jk -> <Esc> insert mode mapping' }
)

-- 2. Create a keymap in NORMAL mode to trigger the toggle.
-- We use <leader>jk here, which is easy to remember.
-- Your <leader> key is probably '\' or ' ' (space).
vim.keymap.set('n', '<leader>jk', JkToggle.toggle, { desc = 'Toggle jk -> <Esc> mapping' })

-- === Initial setup ===
-- Ensure the mapping is set to its default state when your config loads.
if JkToggle.is_enabled then
  JkToggle.enable()
end

-- You can return the module if you want to require it elsewhere, but it's not necessary
-- for this setup to work.
return JkToggle

