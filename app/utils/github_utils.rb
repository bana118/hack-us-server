# frozen_string_literal: true

require "graphql/client"
require "graphql/client/http"

module GithubUtils
  module GraphqlApi
    HTTP = GraphQL::Client::HTTP.new("https://api.github.com/graphql") do
        def headers(context)
          { "Authorization": "Bearer #{ENV["GITHUB_ACCESS_TOKEN"]}" }
        end
      end
    Schema = GraphQL::Client.load_schema(Rails.root.join("app/utils/github_schema.json").to_s)
    Client = GraphQL::Client.new(schema: Schema, execute: HTTP)
    ViewerQuery = Client.parse <<-'GRAPHQL'
        query {
            viewer {
                name
            }
        }
    GRAPHQL
    class << self
      def get_contributions(access_token)
        result = Client.query(ViewerQuery)
        p result.to_h
        result
      end
    end
  end
end
