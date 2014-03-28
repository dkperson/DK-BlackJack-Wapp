module ApplicationHelper
  def full_title(page_title)
    base_title = "DK BlackJack"
    if page_title.empty?
      base_title
    else
      "#{page_title}"
    end
  end
  def flash_class(level)
    case level
      when :notice then "alert-info"
      when :success then "alert-success"
      when :error then "alert-danger"
      when :alert then "alert-warning"
    end
  end

end
