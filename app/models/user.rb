# frozen_string_literal: true

class User < ApplicationRecord
  has_many :projects, foreign_key: :owner_uid, primary_key: :uid, dependent: :destroy
  has_many :participants, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :contributions, -> { order("count DESC") }, dependent: :destroy

  scope :has_language_contribution, -> language_name {
    joins(:contributions).where("contributions.language = ?", language_name).order("contributions.count DESC")
  }

  validates :uid, uniqueness: true
end
