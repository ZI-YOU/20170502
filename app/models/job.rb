class Job < ApplicationRecord
	validates :title,
	          :description,
	          :wage_upper_bound,
	          :wage_lower_bound,
	           presence: true
	validates :wage_lower_bound, numericality: { greater_than: 0 }

end
