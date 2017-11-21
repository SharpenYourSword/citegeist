class User < ApplicationRecord
	has_many :user_groups
	has_many :groups, :through => :user_groups

        validates :email, :presence => true, :uniqueness => true, :case_sensitive => false
        has_secure_password

	scope :active, ->{where(:active => true)}
	scope :for_email, ->(e){where(:email => e)}
	scope :email_order, ->{order("email")}

	validates_uniqueness_of :email, :conditions => ->{where(:active => true)}

	def self.available_permissions
		[
			["User Admin", "user"]
		]
	end

	def display_identifier
		id
	end

	def has_permission_for_group?(g, perm)
		perm = perm.to_s
		gu = user_groups.select{|gu| gu.group_id == g.id}.first
		gu.user_group_permissions.each do |gup|
			return true if gup.permission == perm
		end
		return false
	end
end
