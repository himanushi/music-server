# ref: https://github.com/rmosolgo/graphiql-rails/blob/master/app/controllers/graphiql/rails/editors_controller.rb
module GraphiQL
  module Rails
    class EditorsController < ApplicationController
      def show
         raise Forbidden, "権限がありません" unless current_info[:user].can?("graphiql")
      end

      helper_method :graphql_endpoint_path
      def graphql_endpoint_path
        params[:graphql_path] || raise(%|You must include `graphql_path: "/my/endpoint"` when mounting GraphiQL::Rails::Engine|)
      end
    end
  end
end
