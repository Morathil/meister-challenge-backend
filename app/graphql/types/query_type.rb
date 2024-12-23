# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :node, Types::NodeType, null: true, description: "Fetches an object given its ID." do
      argument :id, ID, required: true, description: "ID of the object."
    end

    def node(id:)
      context.schema.object_from_id(id, context)
    end

    field :nodes, [Types::NodeType, null: true], null: true, description: "Fetches a list of objects given a list of IDs." do
      argument :ids, [ID], required: true, description: "IDs of the objects."
    end

    def nodes(ids:)
      ids.map { |id| context.schema.object_from_id(id, context) }
    end

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    # class QueryType < GraphQL::Schema::Object
    #   description "The query root of this schema"
    
    field :projects, [Types::ProjectType], null: false, description: "Return a list of projects"
    field :tasks, [Types::TaskType], null: false do
      argument :project_id, ID, required: true
    end

    def projects
      Project.all
    end

    def tasks(project_id:)
      Task.where(project_id:)
    end
  end
end
