class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :authenticate_user!, :except => [:showabout]
  before_filter :update_sanitized_params, if: :devise_controller?

  #helper_method :sort_column, :sort_direction

  def search
    case params[:type]
      when "title"
        @events = Event.where("title ILIKE ?", "%" + params[:search] + "%")
        @participants = Participant.all
        @guests = Guest.all
        render 'events/index'
      when "category"
        @events = Event.where("category ILIKE ?", "%" + params[:search] + "%")
        @participants = Participant.all
        @guests = Guest.all
        render 'events/index'
      when "firstname"
        @users = User.where("firstname ILIKE ?", "%" + params[:search] + "%")
        @participants = Participant.all
        @guests = Guest.all
        render 'users/userindex'
      when "lastname"
        @users = User.where("lastname ILIKE ?", "%" + params[:search] + "%")
        @participants = Participant.all
        @guests = Guest.all
        render 'users/userindex'
      else
        render 'none'
    end

  end

  #def sort_column
  #  User.column_names.include?(params[:sort]) ? params[:sort] : "lastname"
  #  Event.column_names.include?(params[:sort]) ? params[:sort] : "dayandtime"
  #end

  #def sort_direction
  #  %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  #end

  protected

  def update_sanitized_params
  	devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:firstname, :lastname, :email, :password, :password_confirmation, :current_password, :gender, :school, :level, :graduation, :filepicker_url, :tagline) }
  	devise_parameter_sanitizer.for(:account_update) {|u| u.permit(:firstname, :lastname, :email, :password, :password_confirmation, :current_password, :gender, :school, :level, :graduation, :filepicker_url, :tagline) }
  end

end
