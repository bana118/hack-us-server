# frozen_string_literal: true

module Mutations
  class CreateParticipant < BaseMutation
    graphql_name "CreateParticipant"

    field :participant, Types::ParticipantType, null: false
    field :result, Boolean, null: true

    argument :uid, String, required: true
    argument :project_id, ID, required: true
    argument :user_approved, Boolean, required: false
    argument :owner_approved, Boolean, required: false

    def resolve(**args)
      user = User.find_by(uid: args[:uid])
      project = Project.find(args[:project_id])

      args.delete(:uid)
      args.delete(:project_id)
      args.store(:user, user)
      args.store(:project, project)

      participant = Participant.create(args)

      if participant.save
        { participant: participant }
      else
        raise GraphQL::ExecutionError, participant.errors.full_messages.join(", ")
      end
    end
  end
end
