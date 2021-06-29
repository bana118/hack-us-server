# frozen_string_literal: true

module Mutations
  class DeleteParticipant < BaseMutation
    graphql_name "DeleteParticipant"

    field :participant, Types::ParticipantType, null: false
    field :result, Boolean, null: true

    argument :id, ID, required: true

    def resolve(id:)
      participant = Participant.find(id)
      participant.destroy!

      { participant: participant }
      rescue ActiveRecord::RecordInvalid => e
        GraphQL::ExecutionError.new("Invalid input: #{e.record.errors.full_messages.join(', ')}")
      end
  end
end
