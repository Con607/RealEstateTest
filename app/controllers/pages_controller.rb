class PagesController < ApplicationController
	layout 'pages'

  def home
  	@estates = Estate.published.first(12)
  end

end
