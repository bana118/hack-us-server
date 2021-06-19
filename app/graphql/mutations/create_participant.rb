# frozen_string_literal: true

module Mutations
  class CreateParticipant < BaseMutation
    graphql_name "CreateParticipant"

    field :participant, Types::PaticipantType, null: false
    field :result, Boolean, null: true

    def resolve(user_id:, project_id:)
      user = User.find(user_id)
      project = Project.find(project_id)
      participant = Participant.create(user: user, project: project)

      {
        participant: participant,
        result: participant.errors.blank?
      }
    end
  end
end