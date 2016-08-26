module ApplicationHelper

  def bootstrap_class_for flash_type
    { success: "alert-success", error: "alert-danger", alert: "alert-warning", notice: "alert-info" }[flash_type.to_s.to_sym] || flash_type.to_s
  end

  def flash_messages(opts = {})
    messages = ''
    flash.each do |msg_type, message|
      messages += content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)} fade in", role: 'alert')
    end
    messages.html_safe
  end

end