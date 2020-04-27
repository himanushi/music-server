class PagesController < ApplicationController
  def index
    _render =
      if Rails.env.production?
        render file: "#{Rails.root}/public/index.html",
                layout: false, status: 200, content_type: 'text/html'
      else
        render file: "#{Rails.root}/public/404.html",
                layout: false, status: 404, content_type: 'text/html'
      end

    respond_to do |format|
      format.html { _render }
    end
  end
end
