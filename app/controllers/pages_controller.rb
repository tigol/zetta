class PagesController < ApplicationController
	def index
	end

	def show
		name = params[:id]
		render name
	end
end
