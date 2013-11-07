module ApplicationHelper

  # for Devise modal signin/up
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def show_user_avatar
    image_tag(current_user.avatar.small.url) if current_user.avatar?
  end
  

  def markdown text
    renderer = Redcarpet::Render::HTML.new
    extensions = { fenced_code_blocks: true, strikethrough: true }
    redcarpet ||= Redcarpet::Markdown.new(renderer, extensions)
    (redcarpet.render text).html_safe
  end
  

  def toastr_flash
    flash_messages = process_flash flash
  end

  def process_flash flash
    flash_messages = []
    flash.each do |type, message|
      if message
        type = check_flash_type type
        text = javascript_tag("toastr.#{type}('#{message}');")
        flash_messages << text.html_safe
      end
    end
    flash_messages.join("\n").html_safe
  end

  def check_flash_type type
    return :success if type == :notice
    return :error if type == :alert
    return :error if type == :error
  end
  
end
