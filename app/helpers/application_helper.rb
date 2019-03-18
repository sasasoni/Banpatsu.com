module ApplicationHelper
  def full_title
    title = "Banpatsu.com"
    title = @page_title + " - " + title if @page_title
    title
  end
end
