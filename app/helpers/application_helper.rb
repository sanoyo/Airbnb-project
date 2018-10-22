module ApplicationHelper
	def avatar_url(user)
		gravatar_id = Digest::MDS::hexdigest(user.email).downcase
		"https://www.gravatarcom/avatar/#{gravatar_id}.jpg?d=identical&s=150"
	end
end
