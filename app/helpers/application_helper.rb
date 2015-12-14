module ApplicationHelper

  def fix_url(str)
    str.starts_with?("http://") ? str : "http://#{str}"
  end

  def display_time(dt)
    dt.strftime("%m/%d/%Y %l:%M%p %Z")
  end
end
