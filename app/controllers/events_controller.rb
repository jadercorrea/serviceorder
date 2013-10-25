class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
    @events = Event.this_month.to_a
  end

  def show
  end

  # GET /events/new
  def new
    @event = Event.new
    @clients = Client.all.map { |m| [m.name, m.id] }
  end

  # GET /events/1/edit
  def edit
    @clients = Client.all.map { |m| [m.name, m.id] }
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params.merge(user_id: current_user.id))

    if @event.save
      redirect_to events_url, notice: 'Event was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:title, :description, :start_datetime, :client_id)
    end
end
