# frozen_string_literal: true

class PagesController < ::ApplicationController
  def index
    # no-cache
    expires_now
    html = ::Html::Ogp.convert(params['path'])

    respond_to do |format|
      format.html do
        render(
          html: html.html_safe,
          layout: false,
          status: 200,
          content_type: 'text/html'
        )
      end
    end
  end
end
