module UsersHelper
  def display_avatar user, size = 50
    if user.avatar.url
      image_tag(user.avatar.to_s, class: "rounded-circle",
        size: "#{size}x#{size}")
    else
      image_tag("ruby.png",
        class: "rounded-circle",
        size: "#{size}x#{size}")
    end
  end
end
