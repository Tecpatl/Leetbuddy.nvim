local M = {}

M.user_config = require("leetbuddy.default_config")

local cmd = require("leetbuddy.selector.view.cmd")

local function create_cmds()
  local questions = require("leetbuddy.questions").questions
  local question = require("leetbuddy.question").question
  local reset = require("leetbuddy.reset").reset_question
  local split = require("leetbuddy.split").split
  local close = require("leetbuddy.split").close_split
  local test = require("leetbuddy.runner").test
  local submit = require("leetbuddy.runner").submit
  local checkcookies = require("leetbuddy.cookies").check_auth

  local opts = {}

  vim.api.nvim_create_user_command("LBQuestions", questions, opts)
  vim.api.nvim_create_user_command("LBQuestion", question, opts)
  vim.api.nvim_create_user_command("LBReset", reset, opts)
  vim.api.nvim_create_user_command("LBSplit", split, opts)
  vim.api.nvim_create_user_command("LBTest", test, opts)
  vim.api.nvim_create_user_command("LBSubmit", submit, opts)
  vim.api.nvim_create_user_command("LBClose", close, opts)
  vim.api.nvim_create_user_command("LBCheckCookies", checkcookies, opts)

  -- selector module substitute
  cmd:setup()
  vim.api.nvim_create_user_command("LeetBuddyCmd", function()
    cmd:startNormal()
  end, {
    nargs = 0,
  })

  require("leetbuddy.functionalities")
end

M.setup = function(opts)
  M.user_config = vim.tbl_deep_extend("force", M.user_config, opts)
  create_cmds()
end

return M
