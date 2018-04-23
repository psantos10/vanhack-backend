class Mutations::CreateUser < GraphQL::Function
  AuthProviderInput = GraphQL::InputObjectType.define do
    name 'AuthProviderSignupData'
    argument :email, Types::AuthProviderEmailInput
  end
  
  argument :first_name, !types.String
  argument :last_name, !types.String
  argument :authProvider, AuthProviderInput

  type Types::AuthenticateType

  def call(_obj, args, ctx)
    user = User.create!(
      first_name: args[:first_name],
      last_name: args[:last_name],
      email: args[:authProvider][:email][:email],
      password: args[:authProvider][:email][:password]
    )

    # TODO: Send email to new user

    # Returned data
    OpenStruct.new({
      token: AuthToken.sign(user),
      user: user
    })
  rescue ActiveRecordInvalid => e
    GraphQL::ExecutionError.new("Invalid input: #{e.record.errors.full_messages.join(', ')}")
  end
end