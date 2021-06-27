# frozen_string_literal: true

module Types
  class LanguageType < Types::BaseObject
    field :name, String, null: false
    field :color, String, null: false
  end
end
