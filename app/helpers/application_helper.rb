module ApplicationHelper

# Instead of creating a helper that takes an array of errors and block of HTML, create a helper that just takes an array of errors and returns a class string.
# Then use ERB interpolation to assign the appropriate set of classes to the surrounding div.

  def my_paginate(collection)
    current_page = params[:page].present? ? params[:page] : '1'
    previous_page = current_page.to_i - 1
    next_page = current_page.to_i + 1
    content_tag :div do
      concat link_to("previous", "/#{controller_name}/?page=#{previous_page}", class: 'disabled') unless current_page == '1'
      concat " "
      concat "<em>#{current_page}</em>".html_safe
      concat " "
      concat link_to("next", "/#{controller_name}/?page=#{next_page}")
    end
  end


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

  def show_user_avatar(user, size=nil)
    if user.avatar?
      if size
        image_tag(user.avatar.url, size: size)
      else
        image_tag(user.avatar.medium.url)
      end
    else
      image_tag(user.gravatar_url(size: '50x50'))
    end
  end

  def show_post_image post
    image_tag(post.image.url) if post.image?
  end

  def markdown text
    renderer = Redcarpet::Render::HTML.new
    extensions = { fenced_code_blocks: true, strikethrough: true }
    redcarpet ||= Redcarpet::Markdown.new(renderer, extensions)
    (redcarpet.render text).html_safe
  end

  # custom will_paginate views

  # def will_paginate(collection_or_options = nil, options = {})
  #   if collection_or_options.is_a?(Hash)
  #     options, collection_or_options = collection_or_options, nil
  #   end
  #   unless options[:renderer]
  #     options = options.merge renderer: FoundationLinkRenderer
  #   end
  #   super *[collection_or_options, options].compact
  # end

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
