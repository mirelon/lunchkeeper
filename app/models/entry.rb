class Entry < ActiveRecord::Base
  belongs_to :keeper
  attr_accessible :code, :count, :description, :preselected, :date

  def self.preselected
    where(preselected: true)
  end

  def to_caption
    [count, code, description].join " "
  end

  def preselected?
    preselected
  end

  def label
    l = ""
    if description.present?
      l = "#{description}"
    end

    if l.present? and code.present?
      l = "#{code} (#{l})"
    elsif code.present?
      l = code
    end

    if l.present? and count.present? and count != 1
      l = "#{count} #{l}"
    elsif l.empty?
      l = count.to_s
    end

    l
  end

end
