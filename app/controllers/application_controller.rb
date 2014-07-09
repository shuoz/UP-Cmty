class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :authenticate_user!, :except => [:showabout]
  before_filter :update_sanitized_params, if: :devise_controller?

  def search
    case params[:type]
      when "title"
        @events = Event.where("title LIKE ?", "%" + params[:search] + "%")
        @participants = Participant.all
        render 'events/index'
      when "category"
        @events = Event.where("category LIKE ?", "%" + params[:search] + "%")
        @participants = Participant.all
        render 'events/index'
      when "firstname"
        @users = User.where("firstname LIKE ?", "%" + params[:search] + "%")
        @participants = Participant.all
        render 'users/index'
      when "lastname"
        @users = User.where("lastname LIKE ?", "%" + params[:search] + "%")
        @participants = Participant.all
        render 'users/index'
      else
        render 'none'
    end
  end

  protected

  def update_sanitized_params
  	devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:firstname, :lastname, :email, :password, :password_confirmation, :current_password, :gender, :school, :level, :graduation, :filepicker_url, :tagline) }
  	devise_parameter_sanitizer.for(:account_update) {|u| u.permit(:firstname, :lastname, :email, :password, :password_confirmation, :current_password, :gender, :school, :level, :graduation, :filepicker_url, :tagline) }
  end

end
