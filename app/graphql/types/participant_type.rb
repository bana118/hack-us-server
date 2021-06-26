# frozen_string_literal: true

module Types
  class ParticipantType < Types::BaseObject
    field :id, ID, null: false
    field :user, Types::UserType, null: false
    field :project, Types::ProjectType, null: false
    field :is_admitted, Boolean, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
