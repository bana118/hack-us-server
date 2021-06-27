# frozen_string_literal: true

module Types
  class ProjectType < Types::BaseObject
    field :id, ID, null: false
    field :owner, Types::UserType, null: false
    field :name, String, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :description, String, null: false
    field :github_url, String, null: false
    field :starts_at, GraphQL::Types::ISO8601DateTime, null: true
    field :ends_at, GraphQL::Types::ISO8601DateTime, null: true
    field :languages, [Types::LanguageType], null: false
    field :recruitment_numbers, Int, null: true
    field :tool_link, String, null: false
    field :contribution, String, null: false
  end
end
