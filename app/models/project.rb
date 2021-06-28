# frozen_string_literal: true

class Project < ApplicationRecord
  belongs_to :owner, class_name: "User", foreign_key: :owner_uid, primary_key: :uid
  has_many :participants
  has_many :favorites
  has_many :languages
end
