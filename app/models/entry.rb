class Entry < ActiveRecord::Base
  attr_accessible :code, :count, :description, :preselected
end
