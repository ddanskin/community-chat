module ApplicationHelper

    def gravatar_for(user, opts = {})
        opts[:alt] = user.name
        image_tag "https://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(user.email)}?s=#{opts.delete(:size) { 40 }}", opts
    end

    def can_see?(private_chat_room)
        current_user.id == private_chat_room.user_id || current_user.id == private_chat_room.other_user_id
    end
end
