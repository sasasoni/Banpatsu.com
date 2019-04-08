module ApplicationHelper

  def full_title(page_title = '')
    base_title = 'Banpatsu.com'
    if page_title.empty?
      base_title
    else
      page_title = page_title + ' - ' + base_title
    end
  end

  def profile_text(text)
    # simple_formatではscriptタグを除去してくれるため、<%== %>, rawを使っても大丈夫そう
    Rinku.auto_link(simple_format(text), :all, 'target="_blank"')
  end

  def google_calendar_url(event)
    base_url = "http://www.google.com/calendar/event?action=TEMPLATE&"
    start_date = event.start_date.strftime("%Y%m%dT%H%M%S")
    end_date = event.end_date.nil? ? start_date : event.end_date.strftime("%Y%m%dT%H%M%S")
    event_url = event.event_url.nil?  ? "" : "%0D%0A" + "URL:" + event.event_url
    base_url + "text=#{event.title}&details=#{truncate(event.description, lengh: 80)}#{event_url}&dates=#{start_date}/#{end_date}"
  end
end
