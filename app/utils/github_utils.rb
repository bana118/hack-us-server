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
                                        color
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
      def get_contributions(github_id)
        result = Client.query(ViewerQuery, variables: { github_id: github_id })
        repositories = result.data.search.nodes[0].contributions_collection.commit_contributions_by_repository
        language_to_contributions = {}
        language_to_color = {}
        for repository in repositories
          language = repository.repository.primary_language.name if repository.repository.primary_language
          language_color = repository.repository.primary_language.color if repository.repository.primary_language
          language_to_color[language] = language_color
          contributions = repository.contributions.total_count
          if language_to_contributions[language].nil?
            language_to_contributions[language] = contributions
          else
            language_to_contributions[language] += contributions
          end
        end
        language_to_contributions.sort_by { |_, v| -v }.to_h.map { |key, val| { "language": key, "color": language_to_color[key], "count": val } }
      end
    end
  end
end
