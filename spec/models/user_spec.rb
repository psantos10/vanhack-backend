require 'rails_helper'

RSpec.describe User, type: :model do
  before(:all) do
    @user = User.new(
      first_name: "John",
      last_name: "Doe",
      email: "john.doe@vanhack.test",
      password: "super$secret$password"
    )
  end

  it "has a valid data" do
    expect(build(:user)).to be_valid
  end

  it "is invalid without a first name" do
    user = build(:user, first_name: nil)
    user.valid?
    expect(user.errors[:first_name]).to include("can't be blank")
  end

  it "is invalid without a last name" do
    user = build(:user, last_name: nil)
    user.valid?
    expect(user.errors[:last_name]).to include("can't be blank")
  end

  it "is invalid without an email address" do
    user = build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end

  it "is invalid with a duplicate email address" do
    create(:user, email: "jane.doe@vanhack.test")
    user = build(:user, email: "jane.doe@vanhack.test")
    user.valid?
    expect(user.errors[:email]).to include("has already been taken")
  end

  it "is invalid with a duplicate email address with upcase characters" do
    create(:user, email: "jane.doe@vanhack.test")
    user = build(:user, email: "JANE.doe@VANHACK.test")
    user.valid?
    expect(user.errors[:email]).to include("has already been taken")
  end

  it "returns a user's full name as a string" do
    user = build(:user, first_name: "Jane", last_name: "Doe")
    expect(user.name).to eq("Jane Doe")
  end
end
