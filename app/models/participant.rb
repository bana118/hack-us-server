# frozen_string_literal: true

class Participant < ApplicationRecord
  belongs_to :user
  belongs_to :project

  # ユーザは同一のプロジェクトに一度しか参加できない
  validates :user,
            uniqueness: {
              scope: :project_id,
              message: 'this user already participated to this project'
            }
end
