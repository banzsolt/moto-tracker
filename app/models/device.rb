class Device < ActiveRecord::Base

  has_many :locations
  belongs_to :user

end
