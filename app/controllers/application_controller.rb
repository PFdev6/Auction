class ApplicationController < ActionController::Base
  add_flash_types :success, :danger
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale

  def set_locale
    return I18n.locale if current_user.nil? 
    if current_user.local == 'ru'
      I18n.locale = :ru
    else 
      I18n.locale = I18n.default_locale
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:avatar])
  end
end
