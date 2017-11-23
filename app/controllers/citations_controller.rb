class CitationsController < ApplicationController
	before_action :login_required
	before_action :setup_citation_scope

	def index
		@citations = @citation_scope.standard_order.page(params[:page]).per(params[:per_page] || 50)
	end

	def create
		@citation = @citation_scope.create!(citation_params)
		flash[:notice] = "Citation created"
		redirect_to citations_path
	end

	def update
		@citation.update_attributes!(citation_params)
		flash[:notice] = "Citation updated"
		redirect_to citations_path
	end

	def show
	end

	def destroy
		@citation.destroy
		flash[:notice] = "Citation successfully deleted"
		redirect_to citations_path
	end

	def setup_citation_scope
		@citation_scope = Citation.where(:group_id => current_group)
		@citation = @citation_scope.find(params[:id]) unless params[:id].blank?
	end

	def citation_params
		params.require(:citation).permit(:document_type, :booktitle, :edition, :journal, :title, :authors, :year, :volume, :issue, :pages, :publisher, :institution, :month, :address, :doi, :pubmed, :url, :note, :editors, :notation_html)
	end
end
