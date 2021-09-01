class SearchesController < ApplicationController
  before_action :authenticate_user!

	def search
		@users = User.all
		@books = Book.all
		@model = params[:model]
		@content = params[:content]
		@method = params[:method]
		if @model == 'user'
			@records = User.search_for(@content, @method)
		else
			@records = Book.search_for(@content, @method)
		end
	end
end
