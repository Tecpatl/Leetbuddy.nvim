local tools = require("leetbuddy.selector.util.tools")
local set = require("leetbuddy.selector.util.set")
local action_state = require("telescope.actions.state")
local telescopeMenu = require("leetbuddy.selector.view.telescope")

---@class SelectRegion
---@field startRow number
---@field startCol number
---@field endRow number
---@field endCol number

---@class Menu
---@field select_region SelectRegion
---@field telescope_menu TelescopeMenu
---@field is_setup boolean
local Menu = {}

Menu.__index = function(self, key)
  local value = rawget(Menu, key)
  if key ~= "setup" then
    if not self.is_setup then
      error("Class not initialized. Please call setup() first.", 2)
    end
  end
  return value
end

Menu.__newindex = function()
  error("Attempt to modify a read-only table")
end

---@return Menu
function Menu:getInstance()
  if not self.instance then
    self.instance = setmetatable({
      select_region = {},
      is_setup = false,
      telescope_menu = telescopeMenu:new(),
    }, self)
  end
  return self.instance
end

function Menu:setup()
  if self.is_setup then
    error("cannot setup twice")
  end
  self.is_setup = true
end

function Menu:LBQuestions()
  local questions = require("leetbuddy.questions").questions
  questions()
end

function Menu:LBQuestion()
  local question = require("leetbuddy.question").question
  question()
end

function Menu:LBReset()
  local reset = require("leetbuddy.reset").reset_question
  reset()
end

function Menu:LBSplit()
  local split = require("leetbuddy.split").split
  split()
end

function Menu:LBTest()
  local test = require("leetbuddy.runner").test
  test()
end

function Menu:LBSubmit()
  local submit = require("leetbuddy.runner").submit
  submit()
end

function Menu:LBClose()
  local close = require("leetbuddy.split").close_split
  close()
end

function Menu:LBCheckCookies()
  local checkcookies = require("leetbuddy.cookies").check_auth
  checkcookies()
end

---@param title string
---@param menuItem SimpleMenu[]
function Menu:telescopeStart(title, menuItem)
  self.telescope_menu:start({
    prompt_title = "LeetBuddy " .. title,
    menu_item = menuItem,
  })
end

return Menu:getInstance()
