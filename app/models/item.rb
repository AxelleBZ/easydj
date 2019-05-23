class Item < ApplicationRecord
  mount_uploader :photo, PhotoUploader
  has_many :rentals
  belongs_to :user

  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?
  validates_presence_of [:name, :price, :condition, :start_date, :end_date, :photo,:location, :deposit]
end

