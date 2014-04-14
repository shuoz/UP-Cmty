class ParticipantsController < ApplicationController
  def new
    @participant = Participant.new
  end

  def create
  	@participant = Participant.new(participant_params)
  	if @participant.save
  	  #will eventually send a notification to event user here
  	  redirect_to events_path
  	else
  	  redirect_to events_path
  	end
  end

  def participant_params
  	params.require(:participant).permit(:user_id, :event_id)
  end

  def destroy
  	@participant = Participant.find(params[:id])
    @participant.destroy
    redirect_to events_path
  end
end
