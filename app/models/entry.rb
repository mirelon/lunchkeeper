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

end
