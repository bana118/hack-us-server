# frozen_string_literal: true

module Mutations
  class CreateParticipant < BaseMutation
    graphql_name "CreateParticipant"

    field :participant, Types::ParticipantType, null: false
    field :result, Boolean, null: true

    argument :uid, String, required: true
    argument :project_id, ID, required: true

    def resolve(uid:, project_id:)
      user = User.find_by(uid: uid)
      project = Project.find(project_id)
      participant = Participant.create(user: user, project: project)

      {
        participant: participant,
        result: participant.errors.blank?
      }
    end
  end
end
