module CalendarHelper
  def calendar_options
    today = today_format
    month = Time.now.month
    @calendar_options = {
        table: { class: 'calendar-body' },
        tr: { class: 'calendar-row' },
        td: -> (start_date, current_calendar_date) {{
            class: "calendar-date #{'today' if today == current_calendar_date.to_s} #{'prev-month' if month > current_calendar_date.month} #{'future' if today < current_calendar_date.to_s}",
            data: { day: current_calendar_date.to_s }
        }}
    }
  end

  def day_title_format(date)
    date = DateTime.parse date unless date.instance_of? DateTime
    "#{Date::MONTHNAMES[date.month]} #{date.day}"
  end

  def today_format
    DateTime.now.strftime '%Y-%m-%d'
  end

  def only_time(datetime)
    datetime.strftime '%H:%M'
  end
end