#encoding: UTF-8
class ObedovatController < ApplicationController
  require 'open-uri'

  def show_menu
    n = Nokogiri::HTML(open('http://obedovat.sk/' + params[:url]))
    menu = n.css('.texthelp')[2]
    menu.search('strong').remove

    menu.search('br').each {|br| br.replace("\r\n") }

    # Kym idu polievky, davam kazdy riadok. Akonahle zacne string zacinajuci A:, menia sa polievku na hlavne jedla, ktore pridavam az ked sa budu koncit znakom euro.
    @items = []
    polievky = true
    accumulator = ""
    in_main_dish = false # som medzi "A: ... euro"
    menu.text.split("\r\n").each do |item|
      if (item =~ /\s*[A-Z]\s*:.*/).present? # zacina A:
        polievky = false
        in_main_dish = true
      end
      if polievky or in_main_dish # ak nie som v polievkach ani medzi "A: ... euro", je to nejaky inner text co treba ignorovat
        accumulator << item
      end
      if polievky or (item =~ /€\s*$/).present? # konci znakom euro
        @items << accumulator
        accumulator = ""
        in_main_dish = false
      end

    end
    @items.delete ""
    @items = @items.map(&:strip_price)
    @items = @items.map(&:strip)
    @items = @items.map do |i|
      parts = i.split(":",2)
      if parts[1].present? and parts[0].length == 1
        { code: parts[0].strip, description: parts[1].strip, label: parts[0].strip+" ("+parts[1].strip+")" }
      else
        { code: nil, description: i, label: i }
      end
    end
  end

  def eat
    @keeper = Keeper.find(params[:keeper_id])
    json = JSON.parse params[:json]
    @added = []
    json.each do |item|
      puts item.inspect
      entry = Entry.new
      entry[:keeper_id] = @keeper.id
      entry[:count] = 1
      entry[:description] = item["description"]
      entry[:code] = item["code"]
      entry[:date] = DateTime.current
      entry[:preselected] = false
      entry.save
      @added << entry
    end
  end
end
