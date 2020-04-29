class PagesController < ApplicationController
  def index
    respond_to do |format|
      format.html {
        render file: "#{Rails.root}/public/index.html",
               layout: false, status: 200, content_type: 'text/html'
      }
    end
  end
end
