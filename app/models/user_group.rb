class UserGroup < ApplicationRecord
	belongs_to :user
	belongs_to :group
	has_many :user_group_permissions

	def permission_ensure_enabled!(perm)
		perm = perm.to_s
		user_group_permissions.each do |gup|
			return if gup.permission == perm
		end
		gup = user_group_permissions.create!(:permission => perm)
	end

	def permission_ensure_disabled!(perm)
		perm = perm.to_s
		user_group_permissions.each do |gup|
			gup.destroy if gup.permission == perm
		end
	end

end
