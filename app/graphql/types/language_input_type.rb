# frozen_string_literal: true

module Types
  class LanguageInputType < Types::BaseInputObject
    argument :name, String, required: true
    argument :color, String, required: true
  end
end
