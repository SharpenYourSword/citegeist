class Citation < ApplicationRecord
	scope :standard_order, ->{order([{:authors => :desc}, {:year => :desc}, {:id => :desc}])}

	def authors_short
		return nil if authors.nil?
		authors.truncate(20)
	end

	def main_title
		title.blank? ? booktitle : title
	end
end
