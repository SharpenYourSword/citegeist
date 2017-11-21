module ApplicationHelper
	def glyph(glph, title)
		raw("<span class='glyphicon glyphicon-#{glph}' title='#{h(title)}'></span>")
	end

	def simple_or_display_field(editable, hdr, val, extra = nil)
		if editable
			simple_field(hdr, val, extra)
		else
			display_field(hdr, val, extra)
		end
	end

	def display_field(hdr, val, extra = nil)
		val = val.object.send(extra) if extra.present?
		raw("<div class='form-group'><label>") + hdr + raw("</label><span class='form-control' disabled='disabled'>") + val.to_s + raw("</span></div>")
	end

	def simple_field(hdr, f, fld)
		raw("<div class='form-group'><label>") + hdr + raw("</label>") + f.text_field(fld, :class => "form-control") + raw("</div>")
	end

	def flash_class(level)
	  case level
	    when :success then "alert-success"
	    when :info, :notice then "alert-info"
	    when :warning, :alert then "alert-warning"
	    when :error then "alert-danger"
	  end
	end

	def title text, opts = {}
		content_for(:title) { text }
		if opts[:class]
			content_for(:title_class){opts[:class]}
		end
	end

	def show_env_if_testing
		if Rails.env == "production"
			""
		else
			raw("<h3>TESTING ENVIRONMENT</h3>")
		end
	end

	def link_to_func(lnk, func, opts = nil)
		opts ||= {}
		opts[:onclick] = "#{opts[:onclick]}; #{func}; return false;"
		confirm_message = opts[:data][:confirm] rescue nil
		if confirm_message.present?
			opts[:onclick] = "if(window.confirm('#{escape_javascript(confirm_message)}')){#{opts[:onclick]}} else { return false; }"
			opts[:data].delete(:confirm)
		end
		link_to(lnk, '#', opts)
	end

	def company_logo(c)
		settings = c.company_settings_info
		if settings.logo_image_file.present?
			begin
				Rails.logger.warn("HERE")
				content_for(:header_logo){ 
					link_to(
						image_tag(
							attachment_url(settings, :logo_image_file), 
							:alt => c.name
						), 
						company_path(c)
					) 
				}
				Rails.logger.warn("THERE")
			rescue
				Rails.logger.warn("LOGO WARNING: #{$!.message}")
			end
		end
	end

	def subtitle text
		content_for(:subtitle) { text }
	end

	def actions(&block)
		content_for(:actions) { block.call }
	end

	def make_paragraphs(val)
		raw val.split(/[\r\n][\r\n]/).map{|x| "<p>" + h(x) + "</p>"}.join
	end

	def allow_tab_links
		render(:partial => "shared/tablinks")
	end
end
