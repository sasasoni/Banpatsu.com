module EventsHelper
  def expired?(start_date, end_date)
    if end_date.nil?
      start_date.end_of_day < Time.current
    else
      end_date < Time.current
    end
  end
end
