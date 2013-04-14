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
    @substring_counts = Hash.new(0)
    @word_counts = Hash.new(0)

    keeper.entries.each do |e|
      if e.description
        pure = UnicodeUtils.downcase(e.description)

        (0..pure.length-1).each do |i|
          (i..pure.length-1).each do |j|
            if pure[i..j].is_ok_for_stats
              @substring_counts [ pure[i..j] ] += 1
            end
          end
        end

        UnicodeUtils.each_word(pure) do |w|
          if w.is_ok_for_stats
            @word_counts[w] += 1
          end
        end

      end
    end

    @substring_counts = @substring_counts.sort_by{|k| k.first.length*k.last*k.last}.reverse.first(1000)
    @word_counts = @word_counts.sort_by{|k| k.last}.reverse.first(1000)

  end

end