module EventsHelper
  def expired?(start_date, end_date)
    if end_date.nil?
      start_date.end_of_day < Time.current
    else
      end_date < Time.current
    end
  end

  def profile_text(text)
    # simple_formatではscriptタグを除去してくれるため、<%== %>, rawを使っても大丈夫そう
    Rinku.auto_link(simple_format(text), :all, 'target="_blank"')
  end
end
