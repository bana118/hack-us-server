module Mutations
  class CreateProject < BaseMutation
    graphql_name "CreateProject"

    field :project, Types::ProjectType, null: true
    field :result, Boolean, null: true

    argument :user_id, ID, required: true
    argument :name, String, required: true

    def resolve(**args)
      user = User.find(args[:user_id])
      project = Project.create(user: user, name: args[:name])
      {
        project: project,
        result: project.errors.blank?
      }
    end
  end
end
