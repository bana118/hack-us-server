# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :createProject, mutation: Mutations::CreateProject
    field :updateProject, mutation: Mutations::UpdateProject
    field :createUser, mutation: Mutations::CreateUser
    field :updateUser, mutation: Mutations::UpdateUser
    field :createParticipant, mutation: Mutations::CreateParticipant
    field :updateParticipant, mutation: Mutations::UpdateParticipant
    field :createFavorite, mutation: Mutations::CreateFavorite
  end
end
