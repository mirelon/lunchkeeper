class EntriesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :init_keeper

  def init_keeper
    @keeper = Keeper.find(params[:keeper_id])
  end

  def init_relevant_fields
    @relevant_fields = {count: false, code: false, description: false}
    @entries.each do |entry|
      @relevant_fields.each do |field, value|
        @relevant_fields[field] |= entry[field].present?
      end
    end
    if @relevant_fields == {count: false, code: false, description: false}
      @relevant_fields = {count: true, code: true, description: true}
    end
  end

  # GET /keepers/1/entries
  # GET /keepers/1/entries.json
  def index
    if params[:preselected]
      @entries = @keeper.entries.where(preselected: true)
    else
      @entries = @keeper.entries.where(preselected: false).order("date DESC")
      @preselected = @keeper.entries.where(preselected: true)
    end
    init_relevant_fields
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @entries }
    end
  end

  # GET /keepers/1/entries/1
  # GET /keepers/1/entries/1.json
  def show
    @entry = Entry.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @entry }
    end
  end

  # GET /keepers/1/entries/new
  # GET /keepers/1/entries/new.json
  def new
    @entry = Entry.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @entry }
    end
  end

  # GET /keepers/1/entries/1/edit
  def edit
    @entry = Entry.find(params[:id])
  end

  # POST /keepers/1/entries
  # POST /keepers/1/entries.json
  def create
    if params[:preselected_id]
      @preselected = Entry.find params[:preselected_id]
      @entry = @preselected.dup
      @entry.preselected = false
      @entry.date = DateTime.current
    else
      @entry = Entry.new()
    end
    @entry.assign_attributes params[:entry]
    @entry.keeper = @keeper

    respond_to do |format|
      if @entry.save
        @was_preselected = @entry.preselected
        format.html { redirect_to listing_path, notice: "Entry was successfully created." }
        format.json { render json: {location: listing_path}}
      else
        format.html { render action: "new" }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /keepers/1/entries/1
  # PUT /keepers/1/entries/1.json
  def update
    @entry = Entry.find(params[:id])

    respond_to do |format|
      if @entry.update_attributes(params[:entry])
        @was_preselected = @entry.preselected
        format.html { redirect_to listing_path, notice: 'Entry was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /keepers/1/entries/1
  # DELETE /keepers/1/entries/1.json
  def destroy
    @entry = Entry.find(params[:id])
    @was_preselected = @entry.preselected
    @entry.destroy

    respond_to do |format|
      format.html { redirect_to listing_path, notice: 'Entry was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  def redirect_to_listing
    redirect_to listing_path
  end

  def listing_path
    if params[:preselected] or @was_preselected
      keeper_preselected_path
    else
      keeper_entries_path
    end
  end

end
