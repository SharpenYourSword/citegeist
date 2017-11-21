class UsersController < ApplicationController
	before_action :group_login_required
	before_action :setup_user
	before_action ->{ permission_required(:user) }, :except => [:index, :change_password_begin, :change_password, :edit]

	def index
		redirect_to edit_user_path(current_user) if !has_permission?(:user)
	end

	def change_password
		begin
			unless has_permission?(:user)
				raise "Invalid password" unless @user.authenticate(params[:original_password])
			end
			raise "Password confirmation does not match" if params[:new_password_confirmation] != params[:new_password]
			raise "Password is too short" if params[:new_password].length < 3
			@user.password = params[:new_password]
			@user.save!
			flash[:notice] = "Password successfully updated"
			redirect_to [:edit, @user]
		rescue
			flash[:error] = "Error updating password: #{$!.message}"
			redirect_to [:change_password_begin, @user]
		end
	end

	def destroy
		@user.user_groups.each do |gu|
			gu.destroy if gu.group_id == current_group.id
		end
		@user.reload
		if @user.user_groups.empty?
			@user.active = false
			@user.save!
		end
		flash[:notice] = "User successfully deleted"
		redirect_to users_path
	end

	def create
		user_params = params.require(:user).permit(:email, :password, :password_confirmation)
		u = User.active.for_email(user_params[:email]).first
		if u.blank?
			u = User.create!(user_params)
		end
		unless current_group.users.include?(u)
			current_group.users << u
		end

		redirect_to [:edit, u]
	end

	def update
		gu = @user.user_groups.select{|gu| gu.group_id == current_group.id}.first
		User.available_permissions.each do |perm|
			if (params[:permissions] || []).include?(perm[1])
				gu.permission_ensure_enabled!(perm[1])
			else
				gu.permission_ensure_disabled!(perm[1])
			end
		end

		flash[:success] = "User successfully updated"
		redirect_to [:edit, @user]
	end

	def setup_user
		# If they don't have user edit permission, then no matter what URL they access they get their own user
		if has_permission?(:user)
			@user = current_group.users.find(params[:id]) unless params[:id].blank?
		else
			@user = current_user
		end
	end	
end
