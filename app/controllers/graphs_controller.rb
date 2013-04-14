class GraphsController < ApplicationController
  
  def index

  end

  def cumulative
    keeper = Keeper.find(params[:keeper_id])
    entries = keeper.entries.where(preselected: false).order("date ASC")

    gon.data = [ { x: keeper.entries_from.to_i * 1000 - 86400000, y: 0 } ]

    entries.each do |e|
      gon.data << { x: e.date.to_i * 1000, y: gon.data.last[:y] + e.count }
    end

    gon.title = keeper.name
  end

  def pie
    keeper = Keeper.find(params[:keeper_id])
    
    gon.data = []

    keeper.entries.order('code').count(group: 'code').each do |key, count|
      if key.present?
        gon.data << {name: key, y: count}
      end
    end

    gon.title = keeper.name
  end

end