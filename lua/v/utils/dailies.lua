local M = {}

M.daily_time = 12

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

  local today = os.date('*t')
  local offset = (today.hour > M.daily_time and 1 or 0) - count
  local first_day = os.date(
    '*t',
    os.time({
      day = today.day + offset - 1,
      month = today.month,
      year = today.year,
    })
  )
  local weekend = first_day.wday == 6 and 2 or 0
  local second_day = os.date(
    '*t',
    os.time({
      day = today.day + offset + weekend,
      month = today.month,
      year = today.year,
    })
  )

  local filepath = ('%s/dailies/%04d/%02d/%02d.md'):format(
    work_dir,
    second_day.year,
    second_day.month,
    second_day.day
  )

  vim.api.nvim_command('keepjumps e ' .. filepath)

  if vim.fn.filereadable(filepath) == 0 then
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
end

return M
