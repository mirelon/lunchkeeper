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

  def stringstats
    keeper = Keeper.find(params[:keeper_id])
    @counts = Hash.new(0)

    keeper.entries.each do |e|
      if e.description
        pure = e.description
        # pure = e.description.remove_non_alpha
        pure = UnicodeUtils.downcase(pure)
        (0..pure.length-1).each do |i|
          (i..pure.length-1).each do |j|
            @counts [ pure[i..j] ] += 1
          end
        end
      end
    end

    @counts = @counts.sort_by{|k| k.first.length*k.last*k.last}.reverse.first(2000)

  end

end