require 'rails_helper'

RSpec.describe User, type: :model do
 
  describe 'Validations' do

    before(:each) do
      @user = User.new(first_name: "Sameer", last_name: "Menda", email: "sam@gmail.com",
      password: "test123", password_confirmation: "test123")
    end

    describe '- User Creation -' do
      it 'should not create user without first name' do
        @user.first_name = nil
        expect(@user).to_not be_valid
        expect(@user.errors.full_messages).to include "First name can't be blank"
      end
      it 'should not create user without last name' do
        @user.last_name = nil
        expect(@user).to_not be_valid
        expect(@user.errors.full_messages).to include "Last name can't be blank"
      end
      it 'should not create user without email' do
        @user.email = nil
        expect(@user).to_not be_valid
        expect(@user.errors.full_messages).to include "Email can't be blank"
      end
      it 'should not create user without password' do
        @user.password = nil
        expect(@user).to_not be_valid
        expect(@user.errors.full_messages).to include "Password can't be blank"
      end
      it 'should not create user without password confirmation' do
        @user.password_confirmation = nil
        expect(@user).to_not be_valid
        expect(@user.errors.full_messages).to include "Password confirmation can't be blank"
      end
      it "should not create user if password and password confirmation don't match" do
        @user.password_confirmation = 'hello123'
        expect(@user).to_not be_valid
        expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password"
      end
      it "should not create user if entered password is less than 3 characters" do
        @user.password = 'ab'
        @user.password_confirmation = 'ab'
        expect(@user).to_not be_valid
        expect(@user.errors.full_messages).to include "Password is too short (minimum is 3 characters)"
      end
      it "should create user if entered password is atleast 3 characters" do
        @user.password = 'abc'
        @user.password_confirmation = 'abc'
        expect(@user).to be_valid
        expect(@user.errors.full_messages).to be_empty
      end
      it 'should create a new user if required details are entered' do
        expect(@user).to be_valid
        expect(@user.errors.full_messages).to be_empty
      end
      it "should not create user if email already exists (email is not case sensitive)" do
        @new_user = User.create(
            first_name: "Madhu",
            last_name: "Nandan",
            email: "SAM@GMAIL.COM",
            password: "hello123",
            password_confirmation: "hello123"
          )
        expect(@user).to_not be_valid
        expect(@user.errors.full_messages).to include "Email has already been taken"
      end
    end



    describe '- .authenticate_with_credentials -' do
      it 'should not login if invalid email is entered' do
        @user.save!
        user = User.authenticate_with_credentials("sap@gmail.com", @user.password)
        expect(user).to eq nil
      end
      it 'should not login if invalid password is entered' do
        @user.save!
        user = User.authenticate_with_credentials(@user.email, "1234")
        expect(user).to eq nil
      end
      it 'should login if valid credentials are entered' do
        @user.save!
        user = User.authenticate_with_credentials(@user.email, @user.password)
        expect(user).to eq @user
      end
      it 'should still login if valid email is entered but with added spaces' do
        @user.save!
        user = User.authenticate_with_credentials("   " + @user.email + "   ", @user.password)
        expect(user).to eq @user
      end
      it 'should still login if valid email is entered but with a different case' do
        @user.save!
        user = User.authenticate_with_credentials("SAM@GMAIL.COM", @user.password)
        expect(user).to eq @user
      end
    end
  
  end
end