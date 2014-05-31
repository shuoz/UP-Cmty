class UsersController < ApplicationController
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

  def index
  	@users = User.all
    @users = User.order(lastname: :asc)
  end

  def show
    @user = User.find(params[:id])
    @events = Event.where(user_id: params[:id])
    @participant = Participant.new
    @participants = Participant.where(user_id: params[:id])
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
end
