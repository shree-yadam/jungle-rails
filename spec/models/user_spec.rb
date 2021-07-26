require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do

    it "saves successfully when all fields are set" do
      @user = User.new
      @user.first_name = 'ABC'
      @user.last_name = 'XYZ'
      @user.email = "abc@xyz.com"
      @user.password = "password"
      @user.password_confirmation = "password"
      @user.save
      expect(@user.errors).to be_empty
    end

    context "must be created with a password and password_confirmation fields" do

      it "validate password presence" do
        @user = User.new
        @user.first_name = 'ABC'
        @user.last_name = 'XYZ'
        @user.email = "abc@xyz.com"
        @user.password = nil
        @user.password_confirmation = "password"
        @user.save
        expect(@user.errors).not_to be_empty
        expect(@user.errors.full_messages).to include "Password can't be blank"
      end

      it "validates password_confirmation presence" do
        @user = User.new
        @user.first_name = 'ABC'
        @user.last_name = 'XYZ'
        @user.email = "abc@xyz.com"
        @user.password = "password"
        @user.password_confirmation = nil
        @user.save
        expect(@user.errors).not_to be_empty
        expect(@user.errors.full_messages).to include "Password confirmation can't be blank"
      end

      it "validates password and password_confirmation being same" do
        @user = User.new
        @user.first_name = 'ABC'
        @user.last_name = 'XYZ'
        @user.email = "abc@xyz.com"
        @user.password = "password"
        @user.password_confirmation = "abc"
        @user.save
        expect(@user.errors).not_to be_empty
        expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password"
      end
    end

    it "validates: email, presence: true" do
      @user = User.new
      @user.first_name = 'ABC'
      @user.last_name = 'XYZ'
      @user.email = nil
      @user.password = "password"
      @user.password_confirmation = "password"
      @user.save
      expect(@user.errors).not_to be_empty
      expect(@user.errors.full_messages).to include "Email can't be blank"
    end

    it "validates: email, error if same email with different case added" do
      @user1 = User.new
      @user1.first_name = 'ABC'
      @user1.last_name = 'XYZ'
      @user1.email = "test@test.com"
      @user1.password = "password"
      @user1.password_confirmation = "password"
      @user1.save
      @user2 = User.new
      @user2.first_name = 'ABC'
      @user2.last_name = 'XYZ'
      @user2.email = "TEST@TEST.com"
      @user2.password = "password"
      @user2.password_confirmation = "password"
      @user2.save
      expect(@user2.errors).not_to be_empty
      expect(@user2.errors.full_messages).to include "Email has already been taken"
    end

    it "validates: first_name, presence: true" do

      @user = User.new
      @user.first_name = nil
      @user.last_name = 'XYZ'
      @user.email = "test@test.com"
      @user.password = "password"
      @user.password_confirmation = "password"
      @user.save
      expect(@user.errors).not_to be_empty
      expect(@user.errors.full_messages).to include "First name can't be blank"
    end

    it "validates: last_name, presence: true" do

      @user = User.new
      @user.first_name = 'ABC'
      @user.last_name = nil
      @user.email = "test@test.com"
      @user.password = "password"
      @user.password_confirmation = "password"
      @user.save
      expect(@user.errors).not_to be_empty
      expect(@user.errors.full_messages).to include "Last name can't be blank"
    end

    it "validates: password minimum length to be 8 characters" do

      @user = User.new
      @user.first_name = 'ABC'
      @user.last_name = 'XYZ'
      @user.email = "test@test.com"
      @user.password = "pass"
      @user.password_confirmation = "pass"
      @user.save
      expect(@user.errors).not_to be_empty
      expect(@user.errors.full_messages).to include "Password is too short (minimum is 8 characters)"
    end
  end

  describe ".authenticate_with_credentials" do

    it "returns instance of user when successful" do
      @user = User.new
      @user.first_name = 'ABC'
      @user.last_name = 'XYZ'
      @user.email = "test@test.com"
      @user.password = "password"
      @user.password_confirmation = "password"
      @user.save
      user = User.authenticate_with_credentials("test@test.com", "password")
      expect(user).to be_instance_of(User)
      expect(user.email).to eq("test@test.com")
      expect(user.first_name).to eq("ABC")
      expect(user.last_name).to eq("XYZ")
    end

    it "returns nil of user when fails" do
      user = User.authenticate_with_credentials("test@test.com", "password")
      expect(user).to be_nil
    end

    it "validates: email, with leading and/or trailing whitespaces"do
      @user = User.new
      @user.first_name = 'ABC'
      @user.last_name = 'XYZ'
      @user.email = "test@test.com"
      @user.password = "password"
      @user.password_confirmation = "password"
      @user.save
      user = User.authenticate_with_credentials("  test@test.com ", "password")
      expect(user).to be_instance_of(User)
      expect(user.email).to eq("test@test.com")
      expect(user.first_name).to eq("ABC")
      expect(user.last_name).to eq("XYZ")
    end

    it "validates: email, case insensitive" do
      @user = User.new
      @user.first_name = 'ABC'
      @user.last_name = 'XYZ'
      @user.email = "test@test.com"
      @user.password = "password"
      @user.password_confirmation = "password"
      @user.save
      user = User.authenticate_with_credentials("TEST@tEst.com", "password")
      expect(user).to be_instance_of(User)
      expect(user.email).to eq("test@test.com")
      expect(user.first_name).to eq("ABC")
      expect(user.last_name).to eq("XYZ")
    end
  end
end
