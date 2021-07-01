# frozen_string_literal: true

module Mutations
  class UpdateParticipant < BaseMutation
    graphql_name "UpdateParticipant"

    field :participant, Types::ParticipantType, null: false
    field :result, Boolean, null: true

    argument :id, ID, required: true
    argument :user_approved, Boolean, required: false
    argument :owner_approved, Boolean, required: false

    # user_approved: ユーザー側の拒否/申請
    # owner_approved: オーナー側の拒否/申請
    def resolve(**args)
      participant = Participant.find(args[:id])
      args.delete(:id)
      participant.update!(args)

      { participant: participant }
    rescue ActiveRecord::RecordInvalid => e
      GraphQL::ExecutionError.new("Invalid input: #{e.record.errors.full_messages.join(', ')}")
    end
  end
end
