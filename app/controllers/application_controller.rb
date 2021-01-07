class ApplicationController < ActionController::Base
  before_action :set_locale

  before_action :configure_permitted_parameters, if: :devise_controller?

  def default_url_options
    I18n.locale.eql?(I18n.default_locale) ? {} : { locale: I18n.locale }
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, alert: exception.message
  end

  check_authorization unless: :devise_controller?

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:avatar])
  end

  def set_locale
    I18n.locale = I18n.locale_available?(params[:locale]) ? params[:locale] : I18n.default_locale
  end
end
