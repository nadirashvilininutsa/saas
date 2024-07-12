class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # before_action :authenticate_user!
  # before_action :check_and_redirect_to_correct_subdomain

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern


  private

  def check_and_redirect_to_correct_subdomain
    current_subdomain = request.subdomain

    if user_signed_in?
      user_subdomain = current_user.organization.subdomain

      if current_subdomain != user_subdomain
        redirect_to root_url(subdomain: user_subdomain), allow_other_host: true
      end
    else
      if current_subdomain.present?
        redirect_to root_url(subdomain: nil), allow_other_host: true
      end
    end
  end
end
