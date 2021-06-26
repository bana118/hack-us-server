# frozen_string_literal: true

module Mutations
  class UpdateParticipant < BaseMutation
    graphql_name "UpdateParticipant"

    field :participant, Types::ParticipantType, null: false
    field :result, Boolean, null: true

    argument :id, ID, required: true
    argument :is_admitted, Boolean, required: true

    # 応募者をプロジェクトに参加させる
    def resolve(id:, is_admitted:)
      participant = Participant.find(id)
      participant.update!({ is_admitted: is_admitted })

      { participant: participant }
    rescue ActiveRecord::RecordInvalid => e
      GraphQL::ExecutionError.new("Invalid input: #{e.record.errors.full_messages.join(', ')}")
    end
  end
end
