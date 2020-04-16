module Queries
  class BaseQuery < GraphQL::Schema::Resolver
    include Types::Scalars

    def selected_fields
      begin
        context.ast_node.selections.first.selections
      rescue
        []
      end
    end

    def selected_field_names
      begin
        selected_fields.map {|field| field.name.underscore.to_sym } - [:__typename]
      rescue
        []
      end
    end
  end
end
