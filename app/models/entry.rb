class Entry < ActiveRecord::Base
  belongs_to :keeper
  attr_accessible :code, :count, :description, :preselected
end
