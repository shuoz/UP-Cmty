class EventsController < ApplicationController
  #helper_method :sort_column, :sort_direction

  def new
  	if user_signed_in?
      @event = Event.new
    else
      redirect_to new_user_session_path
    end
    respond_to do |format|
      format.html
      format.json { render :json => @events }
    end
  end

  def create
  	@event = Event.new(event_params)
    respond_to do |format|
    #@event.dayandtimeend.change(:day => @event.dayandtime.day)
      if @event.user_id != current_user.id
        redirect_to root_path
      else
        if @event.save
          #Notifications.new_event(@event).deliver
          format.html { redirect_to events_path, :notice => 'Event was successfully created.' }
          format.json { render :json => @event, :status => :created, :location => @event }
        else
          format.html { render :action => "new" }
          format.json { render :json => @event.errors, :status => :unprocessable_entity }
        end
      end
    end  	

    #if @event.user_id != current_user.id
    #  redirect_to root_path
    #else
    #  if @event.save
  	#	  redirect_to events_path
  	#  else
  	#	  render 'new'
  	#  end
    #end
  end

  def event_params
  	params.require(:event).permit(:title, :category, :location, :dayandtime, :dayandtimeend, :maxpeople, :user_id)
  end

  def index
    #@events = Event.all
    #@events = Event.order(dayandtime: :asc)
    #@events.each do |event|
    #  Notifications.event_reminder(event).deliver
    #end

    @events = Event.scoped
    @events = Event.between(params['start'], params['end']) if (params['start'] && params['end'])
    #@events = @events.for_user(params[:user_id]) if params[:user_id].present?
    #@events = Event.where(params[:user_id] == current_user.id)
    @participants = Participant.all
    @guests = Guest.all
    if user_signed_in?
      #@events = Event.all
      #@events = Event.order(dayandtime: :asc)
      @events = Event.all(:order => "dayandtime ASC, title ASC")
      #@events = Event.order(sort_column + " " + sort_direction)
    else
      @events = []
    end
    respond_to do |format|
      format.html
      format.json { render :json => @events }
    end
  end

  def show
    @event = Event.find(params[:id])
    @comment = Comment.new
    @comments = Comment.where(event_id: params[:id]).order(updated_at: :desc).limit(10)
    @participant = Participant.new
    @participants = Participant.where(event_id: params[:id]).order(timejoined: :asc)
    @guest = Guest.new
    @guests = Guest.where(event_id: params[:id]).order(updated_at: :asc)
    respond_to do |format|
      format.html
      format.json { render :json => @event }
    end
  end
  
  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    respond_to do |format|
      if @event.user_id != current_user.id
        format.html { render :action => "edit" }
      else
        if @event.update_attributes(event_params)
          format.html { redirect_to event_path(@event.id), :notice => 'Event was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render :action => "edit" }
          format.json { render :json => @event.errors, :status => :unprocessable_entity }
        end
      end
    end

    #if @event.user_id != current_user.id
    #  render 'edit'
    #else
    #  if @event.update_attributes(event_params)
    #    redirect_to event_path(@event.id)
    #  else
    #    render 'edit'
    #  end
    #end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_path, :notice => 'Event was successfully deleted.' }
      format.json { head :no_content }
    end

    #redirect_to events_path
  end

  #def sort_column
  #  Event.column_names.include?(params[:sort]) ? params[:sort] : "dayandtime"
  #end

  #def sort_direction
  #  %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  #end
end
