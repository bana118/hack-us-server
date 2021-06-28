# frozen_string_literal: true

module Types
  class ContributionType < Types::BaseObject
    field :language, String, null: false
    field :color, String, null: false
    field :count, Int, null: false
  end
end
