class Pin < ActiveRecord::Base
  geocoded_by :address #geocoder gem, gets lat&lng by geocoding address
  reverse_geocoded_by :latitude, :longitude #geocoder gem, gets address by reverse geocode lt&lng
  after_validation :geocode, :reverse_geocode
  belongs_to :user
  has_many :comments
  default_scope -> { order('created_at DESC') } #most recent at the beginning
end
