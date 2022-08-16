local M = {}

M.daily_time = 12

---Parse the days to be used in a daily report.
---@param count number
---@return osdate
---@return osdate
local get_report_days = function(count)
  local today = os.date('*t')
  local post_daily = today.hour >= M.daily_time
  local offset = (post_daily and 1 or 0) - count

  local weekend = (today.wday == 2 and not post_daily) and 2 or 0
  local first_day = os.date(
    '*t',
    os.time({
      day = today.day + offset - weekend - 1,
      month = today.month,
      year = today.year,
    })
  )

  weekend = (today.wday == 6 and post_daily) and 2 or 0
  local second_day = os.date(
    '*t',
    os.time({
      day = today.day + offset + weekend,
      month = today.month,
      year = today.year,
    })
  )

  return first_day, second_day
end

---Write the daily report template to a file considering the received dates.
---@param first_day osdate
---@param second_day osdate
local write_report_template_to_file = function(first_day, second_day)
  local report_template = {
    ('# %02d/%02d/%04d'):format(second_day.day, second_day.month, second_day.year),
    '',
    ('## %02d/%02d'):format(first_day.day, first_day.month),
    '',
    '- ',
    '',
    ('## %02d/%02d'):format(second_day.day, second_day.month),
    '',
    '- ',
  }
  vim.api.nvim_buf_set_lines(0, 0, #report_template, false, report_template)
  vim.api.nvim_win_set_cursor(0, { 5, 1 })
  vim.api.nvim_command('noautocmd w!')
end

---Open the Markdown document for a daily report inside $WORK_DIR.
---@param count? number how many days ago the document should be read from
M.open_curr = function(count)
  local work_dir = os.getenv('WORK_DIR')

  if work_dir == '' or vim.fn.isdirectory(work_dir) == 0 then
    print('$WORK_DIR is not set.')
    return
  elseif count == nil then
    count = 0
  end

  local first_day, second_day = get_report_days(count)
  local filepath = ('%s/dailies/%04d/%02d/%02d.md'):format(
    work_dir,
    second_day.year,
    second_day.month,
    second_day.day
  )

  vim.api.nvim_command('keepjumps e ' .. filepath)
  if vim.fn.filereadable(filepath) == 0 then
    write_report_template_to_file(first_day, second_day)
  end
end

return M
