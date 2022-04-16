require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'Task model function',  type: :model do

    user = User.new(name: "test", email: "test@mail.com", password: "password")

    context 'No title entered' do
      it 'Get caught in validation' do
        task = Task.new(title: "", overview: "sample1", user: user)
        expect(task).not_to be_valid
      end
    end

    context 'No overview entered' do
      it 'Get caught in validation' do
        task = Task.new(title: "test2", overview: "", user: user)
        expect(task).not_to be_valid
      end
    end

    context 'The number of title characters exceeds 255' do
      it 'Get caught in validation' do
        task = Task.new(title: "a" * 256, overview: "sample3", user: user)
        expect(task).not_to be_valid
      end
    end

    context 'The number of overview characters exceeds 255' do
      it 'Get caught in validation' do
        task = Task.new(title: "test4", overview: "a" * 256, user: user)
        expect(task).not_to be_valid
      end
    end

    context 'Title and overview are entered' do
      it 'Pass the validation' do
        task = Task.new(title: "test5", overview: "sample5", user: user)
        expect(task).to be_valid
      end
    end
  end
end