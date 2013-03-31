module UsersHelper
	def gravatar_for(current_user)
		gravatar_id = Digest::MD5::hexdigest(current_user.email.downcase)
		gravatar_url = "http://secure.gravatar.com/avatar/#{gravatar_id}"
		image_tag(gravatar_url, alt: current_user.name, class:"img-circle")
	end
end
