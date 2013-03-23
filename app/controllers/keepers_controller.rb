class KeepersController < ApplicationController
  before_filter :authenticate_user!
  # GET /keepers
  # GET /keepers.json
  def index
    @keepers = current_user.keepers

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @keepers }
    end
  end

  # GET /keepers/1
  # GET /keepers/1.json
  def show
    @keeper = Keeper.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @keeper }
    end
  end

  # GET /keepers/new
  # GET /keepers/new.json
  def new
    @keeper = Keeper.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @keeper }
    end
  end

  # GET /keepers/1/edit
  def edit
    @keeper = Keeper.find(params[:id])
  end

  # POST /keepers
  # POST /keepers.json
  def create
    @keeper = Keeper.new(params[:keeper])
    @keeper.user = current_user

    respond_to do |format|
      if @keeper.save
        format.html { redirect_to @keeper, notice: 'Keeper was successfully created.' }
        format.json { render json: @keeper, status: :created, location: @keeper }
      else
        format.html { render action: "new" }
        format.json { render json: @keeper.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /keepers/1
  # PUT /keepers/1.json
  def update
    @keeper = Keeper.find(params[:id])

    respond_to do |format|
      if @keeper.update_attributes(params[:keeper])
        format.html { redirect_to @keeper, notice: 'Keeper was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @keeper.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /keepers/1
  # DELETE /keepers/1.json
  def destroy
    @keeper = Keeper.find(params[:id])
    @keeper.destroy

    respond_to do |format|
      format.html { redirect_to keepers_url }
      format.json { head :no_content }
    end
  end

  def graphs
    keeper = Keeper.find(params[:keeper_id])
    entries = keeper.entries.where(preselected: false).order("date ASC")

    gon.data = [ { x: keeper.entries_from.to_i * 1000 - 86400000, y: 0 } ]

    entries.each do |e|
      gon.data << { x: e.date.to_i * 1000, y: gon.data.last[:y] + e.count }
    end

    gon.title = keeper.name
  end

end
