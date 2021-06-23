# frozen_string_literal: true

module Types
  class ContributionInfoType < Types::BaseObject
    field :language, String, null: false
    field :contributions, Int, null: false
  end
end
