# frozen_string_literal: true

module Mutations
  class CreateProject < BaseMutation
    graphql_name "CreateProject"

    field :project, Types::ProjectType, null: true
    field :result, Boolean, null: true

    argument :owner_uid, String, required: true
    argument :name, String, required: true
    argument :description, String, required: false, description: "プロジェクト概要"
    argument :github_url, String, required: false, description: "GitHubリポジトリURL"
    argument :starts_at, GraphQL::Types::ISO8601DateTime, required: false, description: "開発期間：開始"
    argument :ends_at, GraphQL::Types::ISO8601DateTime, required: false, description: "開発期間：終了"
    argument :languages, [Types::LanguageInputType], required: false, description: "使用言語"
    argument :recruitment_numbers, Int, required: false, description: "募集人数"
    argument :tool_link, String, required: false, description: "コミュニケーションツールのリンク"
    argument :contribution, String, required: false, description: "コントリビュート方法"

    def resolve(**args)
      owner = User.find_by(uid: args[:owner_uid])
      raise GraphQL::ExecutionError, "User ID '#{args[:owner_uid]}' is not found. The project could not be created." if owner.nil?
      project = Project.create({ **args, languages: args[:languages].to_json })
      {
        project: { **project.attributes, "languages": JSON.parse(project.languages), "owner": owner },
        result: project.errors.blank?
      }
    end
  end
end
