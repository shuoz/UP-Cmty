class UsersController < ApplicationController
  helper_method :sort_column, :sort_direction

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
    @user = User.create(user_params)
  	if @user.save
  		redirect_to root_path
  	else
  		render 'new'
  	end
  end

  def user_params
  	params.require(:user).permit(:firstname, :lastname, :email, :password, :gender, :school, :level, :graduation, :filepicker_url, :tagline)
  end

  def userindex
  	@users = User.all
    #@users = User.order(lastname: :asc)
    @users = User.order(sort_column + " " + sort_direction)
  end

  def show
    @user = User.find(params[:id])
    @events = Event.where(user_id: params[:id])
    @participant = Participant.new
    @participants = Participant.where(user_id: params[:id])
    @guest = Guest.new
    @guests = Guest.where(user_id: params[:id])
  end
  
  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to user_path(@user.id)
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to root_path
  end

  def sort_column
    User.column_names.include?(params[:sort]) ? params[:sort] : "lastname"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
