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
end
