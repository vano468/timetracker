module CalendarHelper
  def calendar_options
    today = date_today
    month = DateTime.now.month
    @calendar_options = {
        table: { class: 'calendar-body' },
        tr: { class: 'calendar-row' },
        td: -> (start_date, current_calendar_date) {{
            class: "calendar-date #{'today' if today == current_calendar_date.to_s} #{'prev-month' if month > current_calendar_date.month} #{'future' if today < current_calendar_date.to_s}",
            data: { day: current_calendar_date.to_s }
        }}
    }
  end

  def date_today
    DateTime.now.strftime '%Y-%m-%d'
  end
end