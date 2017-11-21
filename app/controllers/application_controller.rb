class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception

	helper_method :current_group
	helper_method :current_user
	helper_method :has_permission?

	def has_permission?(perm)
		return false if session[:permissions].blank?
		session[:permissions].include?(perm.to_s)
	end

	def current_group
		@current_group ||= Group.active.find(session[:group_id]) if session[:group_id]
		return @current_group rescue nil
	end

	def current_user
		@current_user ||= User.active.find(session[:user_id]) if session[:user_id]
		return @current_user rescue nil
	end

	def permission_required(*perms)
		perms.each do |perm|
			return if has_permission?(perm)
		end
		flash[:error] = "You do not have permission for this page.  Please login as a user with appropriate permissions."
		redirect_to new_session_path
	end
	
	def login_required
		if session[:user_id].blank?
			redirect_to new_session_path
		end
	end

	def group_login_required
		if(session[:user_id].blank? || session[:group_id].blank?)
			redirect_to new_session_path
		end
	end

	def superuser_required
		if session[:user_id].blank?
			redirect_to login_path
		else
			if current_user.superuser?
				# yay!	
			else
				# Not a superuser - go to main regular admin
				redirect_to admin_dashboard_path
			end
		end
	end
end
