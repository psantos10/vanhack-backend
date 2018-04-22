VanhackBackendSchema = GraphQL::Schema.define do
  max_depth 5
  
  use GraphQL::Batch
  enable_preloading

  mutation(Types::MutationType)
  query(Types::QueryType)
end

# 2 seconds is the max time a query should take to be executed
VanhackBackendSchema.middleware <<
  GraphQL::Schema::TimeoutMiddleware.new(max_seconds: 2) do |err, query|
    Rails.logger.info("GraphQL timeout: #{query.query_string}")
  end