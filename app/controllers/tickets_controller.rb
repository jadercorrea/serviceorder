class TicketsController < ApplicationController
  before_filter :load_clients, only: [:new, :edit, :create, :update]
  before_filter :load_users, only: [:new, :edit, :create, :update]

  # GET /tickets
  # GET /tickets.json
  def index
    if current_user.client?
      @tickets = current_user.client.tickets.page(params['page']).per(10)
    else
      @tickets = Ticket.page(params['page']).per(10)
    end 
  end

  # GET /tickets/1
  # GET /tickets/1.json
  def show
    @ticket = Ticket.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ticket }
    end
  end

  # GET /tickets/new
  # GET /tickets/new.json
  def new
    @ticket = Ticket.new
    @ticket.messages.build
  end

  # GET /tickets/1/edit
  def edit
    @ticket = Ticket.find(params[:id])
    @ticket.messages.build
  end

  # POST /tickets
  # POST /tickets.json
  def create
    @ticket = Ticket.new(params[:ticket])
    @ticket.messages.first.user = current_user

    respond_to do |format|
      if @ticket.save
        format.html { redirect_to tickets_path, notice: 'Ticket was successfully created.' }
        format.json { render json: @ticket, status: :created, location: @ticket }
      else
        format.html { render action: "new" }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tickets/1
  # PUT /tickets/1.json
  def update
    @ticket = Ticket.find(params[:id])
    @ticket.messages.select { |msg| msg.user.blank? }.each { |msg| msg.user = current_user }

    params[:ticket][:messages_attributes].each do |key, value|
      params[:ticket][:messages_attributes][key] = value.merge(:user_id => current_user.id)
    end

    if @ticket.update_attributes(params[:ticket])
      redirect_to edit_ticket_path(@ticket), notice: 'Ticket was successfully updated.'
    else
      render action: "edit"
    end
  end

  # DELETE /tickets/1
  # DELETE /tickets/1.json
  def destroy
    @ticket = Ticket.find(params[:id])
    @ticket.destroy

    respond_to do |format|
      format.html { redirect_to tickets_url }
      format.json { head :no_content }
    end
  end

  private

  def load_clients
    @clients = Client.all.map { |m| [m.name, m.id] }
  end

   def load_users
    @users = User.colaborators.map { |m| [m.name, m.id] }
  end
end
