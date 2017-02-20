class ApplicationController < ActionController::Base
  include Pundit
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  alias_method :current_user, :current_guest

  rescue_from Pundit::NotAuthorizedError, with: :guest_not_authorized

  private

  def guest_not_authorized
    flash[:alert] = "Oops, you are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end
end
