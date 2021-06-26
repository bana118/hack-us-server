# frozen_string_literal: true

module Mutations
  class UpdateProject < BaseMutation
    graphql_name "UpdateProject"

    field :project, Types::ProjectType, null: false
    field :result, Boolean, null: true

    argument :id, ID, required: true, description: "プロジェクトID"

    argument :name, String, required: false
    argument :description, String, required: false, description: "プロジェクト概要"
    argument :github_url, String, required: false, description: "GitHubリポジトリURL"
    argument :starts_at, GraphQL::Types::ISO8601DateTime, required: false, description: "開発期間：開始"
    argument :ends_at, GraphQL::Types::ISO8601DateTime, required: false, description: "開発期間：終了"
    argument :technology1, String, required: false, description: "使用技術1"
    argument :technology2, String, required: false, description: "使用技術2"
    argument :technology3, String, required: false, description: "使用技術3"
    argument :technology4, String, required: false, description: "使用技術4"
    argument :technology5, String, required: false, description: "使用技術5"
    argument :recruitment_numbers, Int, required: false, description: "募集人数"
    argument :tool_link, String, required: false, description: "コミュニケーションツールのリンク"
    argument :contribution, String, required: false, description: "コントリビュート方法"

    def resolve(**args)
      project = Project.find(args[:id])
      args.delete(:id)
      project.update!(args)

      { project: project }
    rescue ActiveRecord::RecordInvalid => e
      GraphQL::ExecutionError.new("Invalid input: #{e.record.errors.full_messages.join(', ')}")
    end
  end
end
