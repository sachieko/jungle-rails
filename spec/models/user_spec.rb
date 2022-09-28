require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    # validation tests/examples here
    before(:each) do
      user_sample = {:name => 'Oda Nobunaga', :email => 'nobu@oda.com', :password => 'Topphemlig kommunikation', :password_confirmation => 'Topphemlig kommunikation'}
      @user = User.new(user_sample)
    end

    context 'with all valid fields filled' do
      it 'should save a new user' do
        @user.validate
        expect(@user).to be_valid
        @user.save!

        expect(@user.id).to be_present
      end
    end
    context 'while missing a required field' do
      it 'should not save a user when missing a password or passwords do not match' do
        @user.password = nil
        @user.password_confirmation = nil
        @user.validate
        expect(@user).to be_invalid
        expect(@user.errors[:password]).to include("can't be blank")
        
        @user.password = 'supersecret!'
        @user.password_confirmation = 'invalid'
        @user.validate
        p @user.errors
        expect(@user.errors[:password]).to include("can't be blank")
        @user.save!
        expect(@user.id).to be_nil
      end
    end
  end
end
