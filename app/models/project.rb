# frozen_string_literal: true

class Project < ApplicationRecord
  belongs_to :owner, class_name: "User", foreign_key: :owner_uid, primary_key: :uid
  has_many :participants, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :languages, -> { order("name ASC") }, dependent: :destroy
end
