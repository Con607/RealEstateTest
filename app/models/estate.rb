class Estate < ApplicationRecord
	has_many :pictures, dependent: :destroy


	def self.published
		where(published: true)
	end

	def self.unpublished
		where(published: true)
	end

	def self.by_company(company)
		where(origin_company: company)
	end

end
