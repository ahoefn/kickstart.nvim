vim.opt.shell = 'pwsh'
vim.opt.shellcmdflag =
  '-NoLogo -NonInteractive -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;'
vim.opt.shellredir = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode'
vim.opt.shellpipe = '2>&1 | %%{ "$_" } | Tee-Object %s; exit $LastExitCode'
vim.opt.shellquote = ''
vim.opt.shellxquote = ''

-- file paths
local uri_module = require 'vim.uri'
local original_uri_to_fname = uri_module.uri_to_fname

local function canonical_uri_to_fname(uri)
  local file_name = original_uri_to_fname(uri)
  file_name = file_name:gsub('^%a:', string.upper) -- c:\ -> C:\
  file_name = file_name:gsub('/', '\\') -- / -> \
  return file_name
end

uri_module.uri_to_fname = canonical_uri_to_fname
vim.uri_to_fname = canonical_uri_to_fname
