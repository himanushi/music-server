class PagesController < ApplicationController
  def index

    # OGP 付与
    html = Html::Ogp.convert(params["path"])

    respond_to do |format|
      format.html {
        render html: html.html_safe,
               layout: false, status: 200, content_type: 'text/html'
      }
    end
  end
end
