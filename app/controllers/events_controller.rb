class EventsController < ApplicationController
  def new
  	if user_signed_in?
      @event = Event.new
    else
      redirect_to new_user_session_path
    end
  end

  def create
  	@event = Event.new(event_params)
  	if @event.user_id != current_user.id
      redirect_to root_path
    else
      if @event.save
  		  redirect_to events_path
  	  else
  		  render 'new'
  	  end
    end
  end

  def event_params
  	params.require(:event).permit(:title, :location, :dayandtime, :dayandtimeend, :maxpeople, :user_id)
  end

  def index
    if user_signed_in?
      @events = Event.all
      @events = Event.order(dayandtime: :asc)
    else
      @events = []
    end
  end

  def show
    @event = Event.find(params[:id])
    @comment = Comment.new
    @comments = Comment.where(event_id: params[:id])
  end
  
  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.user_id != current_user.id
      render 'edit'
    else
      if @event.update_attributes(event_params)
        redirect_to event_path(@event.id)
      else
        render 'edit'
      end
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to events_path
  end
end
