class Keeper < ActiveRecord::Base
  belongs_to :user
  has_many :entries
  attr_accessible :name

  def entries_from
    entries.order('created_at ASC').first.created_at
  end

  def entries_to
    entries.order('created_at DESC').first.created_at
  end

end
