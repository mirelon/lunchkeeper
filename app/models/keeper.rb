class Keeper < ActiveRecord::Base
  belongs_to :user
  has_many :entries
  attr_accessible :name

  def entries_from
    entries.order('date ASC').first.date
  end

  def entries_to
    entries.order('date DESC').first.date
  end

end
