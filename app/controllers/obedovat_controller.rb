class ObedovatController < ApplicationController
  require 'open-uri'

  def show_menu
    puts params.inspect
    n = Nokogiri::HTML(open('http://obedovat.sk/' + params[:url]))
    menu = n.css('.texthelp')[2]
    menu.search('strong').remove
    @items = menu.text.split("\r\n")
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
  end
end
