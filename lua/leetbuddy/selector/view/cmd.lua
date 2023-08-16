local menu = require("leetbuddy.selector.view.menu")
local tools = require("leetbuddy.selector.util.tools")

---@class Cmd
---@field telescope_menu TelescopeMenu
---@field is_setup boolean
local Cmd = {}

Cmd.__index = function(self, key)
  local value = rawget(Cmd, key)
  if key ~= "setup" then
    if not self.is_setup then
      error("Class not initialized. Please call setup() first.", 2)
    end
  end
  return value
end

Cmd.__newindex = function()
  error("Attempt to modify a read-only table")
end

---@return Cmd
function Cmd:getInstance()
  if not self.instance then
    self.instance = setmetatable({
      is_setup = false,
      telescope_menu = {},
    }, self)
  end
  return self.instance
end

function Cmd:setup()
  if self.is_setup then
    error("cannot setup twice")
  end
  self.is_setup = true
  menu:setup()
end

---@type SimpleMenu[]
local emptyVisualMenu = {}

---@type SimpleMenu[]
local emptyNormalMenu = {}

---@type SimpleMenu[]
local visualMenu = tools.table_concat({
}, emptyVisualMenu)

---@type SimpleMenu[]
local normalMenu = tools.table_concat({
  {
    name = "LBQuestions",
    foo = function()
      return menu:LBQuestions()
    end,
  },
  {
    name = "LBQuestion",
    foo = function()
      return menu:LBQuestion()
    end,
  },
  {
    name = "LBReset",
    foo = function()
      return menu:LBReset()
    end,
  },
  {
    name = "LBSplit",
    foo = function()
      return menu:LBSplit()
    end,
  },
  {
    name = "LBTest",
    foo = function()
      return menu:LBTest()
    end,
  },
  {
    name = "LBSubmit",
    foo = function()
      return menu:LBSubmit()
    end,
  },
  {
    name = "LBClose",
    foo = function()
      return menu:LBClose()
    end,
  },
  {
    name = "LBCheckCookies",
    foo = function()
      return menu:LBCheckCookies()
    end,
  },
}, emptyNormalMenu)


---@param content string
function Cmd:startVisual(content)
  local menuList = visualMenu
  local msg = "visualMenu"
  menu:telescopeStart(msg, menuList)
end

function Cmd:startNormal()
  local menuList = normalMenu
  local msg = "NormalMenu"
  menu:telescopeStart(msg, menuList)
end

return Cmd:getInstance()
