class Pin < ActiveRecord::Base
  #geocoded_by :address
  #after_validation :geocode
  geocoded_by :address
  reverse_geocoded_by :latitude, :longitude
  after_validation :geocode, :reverse_geocode

  has_one :user
  
  #belongs_to :user
  default_scope -> { order('created_at DESC') }
  #validates :user_id, presence: true
  #validates :activity_type, presence: true
end
