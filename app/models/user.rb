# frozen_string_literal: true

class User < ApplicationRecord
  has_many :projects, foreign_key: :owner_id
  has_many :participants
  validates :uid, uniqueness: true
end
