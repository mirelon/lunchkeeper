class EntriesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_keeper

  def load_keeper
    @keeper = Keeper.find(params[:keeper_id])
  end


  # GET /keepers/1/entries
  # GET /keepers///entries.json
  def index
    @entries = Entry.where(preselected: false)

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
    @entry = Entry.new(params[:entry])

    respond_to do |format|
      if @entry.save
        format.html { redirect_to keeper_entries_path @keeper, notice: 'Entry was successfully created.' }
        format.json { render json: @entry, status: :created, location: @entry }
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
        format.html { redirect_to [@keeper, @entry], notice: 'Entry was successfully updated.' }
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
    @entry.destroy

    respond_to do |format|
      format.html { redirect_to keeper_entries_url }
      format.json { head :no_content }
    end
  end
end
