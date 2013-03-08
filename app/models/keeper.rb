class Keeper < ActiveRecord::Base
  belongs_to :user
  has_many :entries
  attr_accessible :name
end
