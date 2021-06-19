# frozen_string_literal: true

module Mutations
  class CreateProject < BaseMutation
    graphql_name "CreateProject"

    field :project, Types::ProjectType, null: true
    field :result, Boolean, null: true

    argument :ownerUid, String, required: true
    argument :name, String, required: true

    def resolve(**args)
      owner = User.find_by(uid: args[:ownerUid])
      project = Project.create(owner: owner, name: args[:name])
      {
        project: project,
        result: project.errors.blank?
      }
    end
  end
end
