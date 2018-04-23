Types::QueryType = GraphQL::ObjectType.define do
  name "Query"
  description "The query root of this Schema"

  field :currentUser, Types::UserType do
    description "An example field added by the generator"
    resolve ->(obj, args, ctx) {
      ctx[:current_user]
    }
  end
end
