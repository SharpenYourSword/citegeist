class SessionsController < ApplicationController
	def create
		begin
			u = User.active.for_email(params[:email]).first
			if(u.authenticate(params[:password]))
				session[:user_id] = u.id
				flash[:success] = "Welcome #{u.email}!"
				# if u.global_admin?
				# 	redirect_to global_admin_groups_path # FIXME - This path doesn't exist
				# else
					set_user_group(u.groups.active.first)
					redirect_to dashboard_path
				# end
			else
				raise "Invalid password"
			end
		rescue
			flash[:error] = "Invalid login"
			Rails.logger.warn($!.message)
			Rails.logger.warn($!.backtrace.inspect)
			redirect_to new_session_path
		end
	end

	def set_user_group(g)
		user_group = current_user.user_groups.each do |ug|
			if ug.group_id == g.id
				session[:group_id] = g.id
				session[:permissions] = ug.user_group_permissions.map{|x| x.permission}
				return
			end
		end
	end

	def show
		redirect_to dashboard_path
	end

	def destroy
		flash[:success] = "You have been logged out"
		reset_session
		redirect_to new_session_path
	end
end
