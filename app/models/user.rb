# frozen_string_literal: true

class User < ApplicationRecord
  has_many :projects, foreign_key: :owner_uid, primary_key: :uid
  has_many :participants
  has_many :favorites
  has_many :contributions

  validates :uid, uniqueness: true
end
