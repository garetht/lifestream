class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_in_path_for(resource)
    stream_posts_url(current_user.default_stream_id)
  end
end