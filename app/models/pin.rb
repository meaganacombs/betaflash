class Pin < ActiveRecord::Base
  #geocoded_by :address
  #after_validation :geocode
  geocoded_by :address
  reverse_geocoded_by :latitude, :longitude
  after_validation :geocode, :reverse_geocode

 # has_and_belongs_to_many :users
  
  belongs_to :user
  has_many :comments
  default_scope -> { order('created_at DESC') }
  #validates :user_id, presence: true
  #validates :activity_type, presence: true
end
