module Resolvers
    class ProjectResolver < BaseResolver
      type Types::ProjectType, null: false
      argument :id, ID
  
      def resolve(id:)
        ::Project.find(id)
      end
    end
  end