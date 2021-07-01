# frozen_string_literal: true

module Types
  class RecommendType < Types::BaseObject
    field :language, String, null: false
    field :projects, [Types::ProjectType], null: false
  end
end
