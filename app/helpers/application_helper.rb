module ApplicationHelper
  def asset_exists?
    asset = "#{params[:controller]}.css"
    if Rails.configuration.assets.compile
      Rails.application.precompiled_assets.include? asset
    else
      Rails.application.assets_manifest.assets[asset].present?
    end
  end

  def current_user
    User.find_by_id(session[:user]) if is_logged?
  end

  def is_logged?
    session[:user] != nil
  end
end
