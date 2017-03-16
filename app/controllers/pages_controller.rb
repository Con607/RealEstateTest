class PagesController < ApplicationController
	layout 'pages'

  def home
  	#@estates = Estate.published.order(:title).page params[:page]
  	@estates = Estate.search(params[:search], 21).published.order(:title).page params[:page]
  end

end
