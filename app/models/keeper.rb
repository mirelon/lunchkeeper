class Keeper < ActiveRecord::Base
  belongs_to :user
  has_many :entries
  attr_accessible :name

  def entries_from
    entries.where(preselected: false).order('date ASC').first.date
  end

  def entries_to
    entries.where(preselected: false).order('date DESC').first.date
  end

end
