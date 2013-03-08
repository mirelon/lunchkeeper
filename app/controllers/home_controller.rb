class HomeController < ApplicationController

  def index
    unless user_signed_in?
      redirect_to keepers_path
    end
  end

end
