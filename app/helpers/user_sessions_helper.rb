module UserSessionsHelper

  def sign_in(user)
    persistence_token = User.new_persistence_token
    cookies.permanent[:persistence_token] = persistence_token
    user.update_attribute(:persistence_token, User.hash(persistence_token))
    self.current_user = user
  end
end
