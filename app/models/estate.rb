class Estate < ApplicationRecord
	has_many :pictures, dependent: :destroy

	# For kaminari
	paginates_per 21
	#max_paginates_per 100


	def self.published
		where(published: true)
	end

	def self.unpublished
		where(published: true)
	end

	def self.by_company(company)
		where(origin_company: company)
	end

	def self.by_property_id(property_id)
		where(property_id: property_id)
	end

	def self.with_title(title)
		where('title LIKE ?', "%#{title}%")
	end

	def self.search(search, page)
	  if search
	    with_title(search).published.order('title DESC')#.page(current_page)
	  else
	    # note: default is all, just sorted
	    order('title DESC')#.page(current_page) 
	  end
	end

	def self.publish
		update(published: true)
	end

	def self.unpublish
		update(published: false)
	end

end
