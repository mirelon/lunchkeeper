class PreselectedController < EntriesController
  before_filter :authenticate_user!
  before_filter :load_keeper

  # GET /keepers/1/preselected
  # GET /keepers/1/preselected.json
  def index
    @entries = Entry.where(preselected: true)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @entries }
    end
  end
end
