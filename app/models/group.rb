class Group < ApplicationRecord
	has_many :user_groups
	has_many :users, :through => :user_groups
	has_many :events
	has_many :races, through: :events
	has_many :photos

	scope :active, ->{where(:active => true)}
end
