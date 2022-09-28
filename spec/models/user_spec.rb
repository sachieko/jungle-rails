require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    # validation tests/examples here
    before(:each) do
      user_sample = {:name => 'Oda Nobunaga', :email => 'nobu@oda.com', :password => 'Topphemlig kommunikation', :password_confirmation => 'Topphemlig kommunikation'}
      copycat_sample = {:name => 'Akechi Mitsuhide', :email => 'nobu@oda.com', :password => 'honnoji', :password_confirmation => 'honnoji'}
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
    end
  end
end
