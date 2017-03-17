class Picture < ApplicationRecord
	belongs_to :estate

	validates :estate_id, presence: true
	
end
