# frozen_string_literal: true

::Rails.application.routes.draw do
  post '/graphql', to: 'graphql#execute'

  mount ::GraphiQL::Rails::Engine, at: '/graphiql', graphql_path: '/graphql'

  root 'pages#index'
  get '/*path', to: 'pages#index', via: :all
end
