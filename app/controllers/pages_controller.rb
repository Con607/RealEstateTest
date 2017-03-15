class PagesController < ApplicationController
	layout 'pages'

  def home
  	@estates = Estate.first(9)
  end

end
