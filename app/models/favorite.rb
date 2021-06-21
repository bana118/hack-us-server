# frozen_string_literal: true

class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :project

  # ユーザは同一のプロジェクトに一度しかお気に入り登録できない
  validates :user,
            uniqueness: {
              scope: :project_id,
              message: "this user already created favorite-record of this project"
            }
end
