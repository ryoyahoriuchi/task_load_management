require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'User model function', type: :model do
    context 'No name entered' do
      it 'Get caught in validation' do
        user = User.new(name: '', email: 'test@mail.com', password: 'password')
        expect(user).not_to be_valid
      end
    end

    context 'No email entered' do
      it 'Get caught in validation' do
        user = User.new(name: 'test', email: '', password: 'password')
        expect(user).not_to be_valid
      end
    end

    context 'No password entered' do
      it 'Get caught in validation' do
        user = User.new(name: 'test', email: 'test@mail.com', password: '')
        expect(user).not_to be_valid
      end
    end

    context 'Password is 5 characters or less' do
      it 'Get caught in validation' do
        user = User.new(name: 'test', email: 'test@mail.com', password: 'a' * 5)
        expect(user).not_to be_valid
      end
    end

    context 'Name and email and password are entered' do
      it 'Pass the validation' do
        user = User.new(name: 'test', email: 'test@mail.com', password: 'password')
        expect(user).to be_valid
      end
    end
  end
end
