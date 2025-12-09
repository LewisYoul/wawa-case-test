require 'rails_helper'

RSpec.describe User, type: :model do
  it "requires a username" do
    user = User.new(email_address: "test@example.com", password: "password")

    expect(user.valid?).to be(false)
    expect(user.errors.full_messages).to include("Username can't be blank")
  end

  it "requires a unique username" do
    User.create(username: "test", email_address: "test@example.com", password: "password")
    user = User.new(username: "test", email_address: "test2@example.com", password: "password")

    expect(user.valid?).to be(false)
    expect(user.errors.full_messages).to include("Username has already been taken")
  end

  it "requires an email address" do
    user = User.new(username: "test", password: "password")

    expect(user.valid?).to be(false)
    expect(user.errors.full_messages).to include("Email address can't be blank")
  end

  it "requires a unique email address" do
    User.create(username: "test", email_address: "test@example.com", password: "password")
    user = User.new(username: "test2", email_address: "test@example.com", password: "password")

    expect(user.valid?).to be(false)
    expect(user.errors.full_messages).to include("Email address has already been taken")
  end

  it "requires a password" do
    user = User.new(username: "test", email_address: "test@example.com")

    expect(user.valid?).to be(false)
    expect(user.errors.full_messages).to include("Password can't be blank")
  end

  it "requires a password confirmation" do
    user = User.new(username: "test", email_address: "test@example.com", password: "password", password_confirmation: "password2")
  end
end
