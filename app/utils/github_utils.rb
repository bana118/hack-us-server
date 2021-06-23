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
        query($github_id: String!) {
            search (query: $github_id, type: USER, first: 1) {
                nodes {
                    ... on User {
                        contributionsCollection {
                            commitContributionsByRepository(maxRepositories: 100) {
                                repository {
                                    primaryLanguage {
                                        name
                                    }
                                }
                                contributions {
                                    totalCount
                                }
                            }
                        }
                    }
                }
            }
        }
    GRAPHQL
    class << self
      def get_contribution_info(github_id)
        result = Client.query(ViewerQuery, variables: { github_id: github_id })
        repositories = result.data.search.nodes[0].contributions_collection.commit_contributions_by_repository
        language_to_contributions = {}
        for repository in repositories
          language = repository.repository.primary_language.name
          contributions = repository.contributions.total_count
          if language_to_contributions[language].nil?
            language_to_contributions[language] = contributions
          else
            language_to_contributions[language] += contributions
          end
        end
        language_to_contributions.map { |key, val| { "language": key, "contributions": val } }
      end
    end
  end
end
