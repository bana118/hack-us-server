# frozen_string_literal: true

class AddColumnParticipants < ActiveRecord::Migration[6.1]
  def change
    add_column :participants, :is_admitted, :Boolean, default: false, null: false, comment: "プロジェクトに応募している or 参加している"
  end
end
