# frozen_string_literal: true

class User < ApplicationRecord
  validates :uid, uniqueness: true
end
