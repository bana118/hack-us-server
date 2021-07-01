# frozen_string_literal: true

class ChangeColumnParticipants < ActiveRecord::Migration[6.1]
  def change
    remove_column :participants, :is_admitted, :Boolean
    add_column :participants, :user_approved, :Boolean, default: nil, null: true, comment: "false: 参加を拒否, true: 参加を承認"
    add_column :participants, :owner_approved, :Boolean, default: nil, null: true, comment: "false: 参加を拒否, true: 参加を承認"
  end
end
