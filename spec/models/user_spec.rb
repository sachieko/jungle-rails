require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    # validation tests/examples here
    before(:each) do
      user_sample = {:first_name => 'Nobunaga', :last_name => 'Oda', :email => 'nobu@oda.com', :password => 'Topphemlig kommunikation', :password_confirmation => 'Topphemlig kommunikation'}
      copycat_sample = {:first_name => 'Mitsuhide', :last_name => 'Akechi', :email => 'nobu@oda.com', :password => 'Topphemlig kommunikation', :password_confirmation => 'Topphemlig kommunikation'}
      @user = User.new(user_sample)
      @copycat = User.new(copycat_sample)
    end

    context 'with all valid fields filled' do
      it 'should save a new user' do
        @user.validate
        expect(@user).to be_valid
        @user.save!

        expect(@user.id).to be_present
      end
    end
    context 'while missing or having an invalid field' do
      it 'should not save a user missing a password or passwords do not match' do
        @user.password = nil
        @user.password_confirmation = 'invalid'
        @user.validate
        expect(@user).to be_invalid
        expect(@user.errors[:password]).to include("can't be blank")
        
        @user.password = 'supersecret!'
        @user.validate
        expect(@user.errors[:password_confirmation]).to include("doesn't match Password")
        expect(@user).to be_invalid # should still be invalid
        expect(@user.id).to be_nil # should not have an id
      end
      it 'should not save if a user has a password less than the minimum length 8' do
        @user.password = 'hello'
        @user.password_confirmation = 'hello'
        @user.validate
        expect(@user).to be_invalid
        expect(@user.errors[:password]).to include("is too short (minimum is 8 characters)")
      end
      it 'should not save a user missing email' do
        @user.email = nil
        @user.validate

        expect(@user).to be_invalid
        expect(@user.errors[:email]).to include("can't be blank")
        expect(@user.id).to be_nil
      end
      it 'should not save a user with a duplicate email' do
        @user.save!
        expect(@user.id).to be_present
        
        @copycat.validate
        expect(@copycat).to be_invalid
        expect(@copycat.errors[:email]).to include("has already been taken")
        expect(@copycat.id).to be_nil
      end
      it 'should not save a user without first or last names' do
        @user.first_name = nil
        @user.validate
        expect(@user.errors[:first_name]).to include("can't be blank")
        expect(@user).to be_invalid

        @copycat.last_name = nil
        @copycat.validate
        expect(@copycat.errors[:last_name]).to include("can't be blank")
        expect(@copycat).to be_invalid
      end
    end
  end
  
  describe '.authenticate_with_credentials' do
    before(:each) do
      user_sample = {:first_name => 'Nobunaga', :last_name => 'Oda', :email => 'nobu@oda.com', :password => 'Topphemlig kommunikation', :password_confirmation => 'Topphemlig kommunikation'}
      userTwo_sample = {:first_name => 'Shingen', :last_name => 'Takeda', :email => 'best@takeda.com', :password => 'honnouji', :password_confirmation => 'honnouji'}
      @user = User.create(user_sample)
      @userTwo = User.create(userTwo_sample)
    end

    context 'with valid email and password the correct user should be returned' do
      it 'should return the user with exact matching email and password' do
        validUser = User.authenticate_with_credentials('nobu@oda.com', 'Topphemlig kommunikation')
        validUserTwo = User.authenticate_with_credentials('best@takeda.com', 'honnouji')
        expect(validUser).to be_present
        expect(validUser.id).to be_present
        expect(validUser.first_name).to be_present
        expect(validUserTwo).to be_present
        expect(validUserTwo.id).to be_present
      end
      it 'should return the user with matching email of different case and exact password' do
        validUser = User.authenticate_with_credentials('nObU@ODa.cOm', 'Topphemlig kommunikation')
        validUserTwo = User.authenticate_with_credentials('beSt@takeDa.com', 'honnouji')
        expect(validUser).to be_present
        expect(validUser.id).to be_present
        expect(validUser.first_name).to be_present
        expect(validUserTwo).to be_present
        expect(validUserTwo.id).to be_present
      end
      it 'should return the user with matching email with trailing whitespace and exact password' do
        validUser = User.authenticate_with_credentials('  nobu@oda.com ', 'Topphemlig kommunikation')
        validUserTwo = User.authenticate_with_credentials(' best@takeda.com  ', 'honnouji')
        expect(validUser).to be_present
        expect(validUser.id).to be_present
        expect(validUser.first_name).to be_present
        expect(validUserTwo).to be_present
        expect(validUserTwo.id).to be_present
      end
    end
    context 'with improper credentials, no user should be returned' do
      it 'should return nil for user with the wrong password for the email' do
        invalidUser = User.authenticate_with_credentials('nobu@oda.com', 'honnouji')
        expect(invalidUser).to be_nil
      end
      it 'should return nil for user with a non-case sensitive password' do
        invalidUser = User.authenticate_with_credentials('nobu@oda.com', 'topphemlig kommunikation')
        expect(invalidUser).to be_nil 
      end
      it 'should return nil for user with a password that has trailing whitespace' do
        invalidUser = User.authenticate_with_credentials('best@takeda.com ', 'honnouji ')
        expect(invalidUser).to be_nil
      end
    end
  end
end
