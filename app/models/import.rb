class Import < ActiveRecord::Base
  has_many :entries
  belongs_to :user
end
