class GuestsController < ApplicationController
  def new
    @guest = Guest.new
  end

  def create
  	@guest = Guest.new(guest_params)
  	if @guest.save
  	  #will eventually send a notification to event user here
  	  redirect_to event_path(@guest.event_id)
  	else
  	  redirect_to events_path
  	end
  end

  def guest_params
  	params.require(:guest).permit(:user_id, :event_id, :participant_id)
  end

  def destroy
  	@guest = Guest.find(params[:id])
    @guest.destroy
    redirect_to event_path(@guest.event_id)
  end
end
