# frozen_string_literal: true

class User < ApplicationRecord
  has_many :projects, foreign_key: :owner_uid, primary_key: :uid
  has_many :participants
  has_many :favorites
  has_many :contributions, -> { order("count DESC") }
  accepts_nested_attributes_for :contributions

  scope :has_language_contribution, -> language_name {
    joins(:contributions).where("contributions.language = ?", language_name).order("contributions.count DESC")
  }

  validates :uid, uniqueness: true
end
