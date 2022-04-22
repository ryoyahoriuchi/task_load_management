require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'Task model function', type: :model do
    user = User.new(name: 'test', email: 'test@mail.com', password: 'password')

    context 'No title entered' do
      it 'Get caught in validation' do
        task = Task.new(title: '', overview: 'sample1', user: user)
        expect(task).not_to be_valid
      end
    end

    context 'No overview entered' do
      it 'Get caught in validation' do
        task = Task.new(title: 'test2', overview: '', user: user)
        expect(task).not_to be_valid
      end
    end

    context 'The number of title characters exceeds 255' do
      it 'Get caught in validation' do
        task = Task.new(title: 'a' * 256, overview: 'sample3', user: user)
        expect(task).not_to be_valid
      end
    end

    context 'The number of overview characters exceeds 255' do
      it 'Get caught in validation' do
        task = Task.new(title: 'test4', overview: 'a' * 256, user: user)
        expect(task).not_to be_valid
      end
    end

    context 'Title and overview are entered' do
      it 'Pass the validation' do
        task = Task.new(title: 'test5', overview: 'sample5', user: user)
        expect(task).to be_valid
      end
    end
  end

  describe 'scope' do
    let!(:first_user) { FactoryBot.create(:first_user) }
    let!(:first_label) { FactoryBot.create(:first_label) }
    let!(:second_label) { FactoryBot.create(:second_label) }
    let!(:third_label) { FactoryBot.create(:third_label) }
    let!(:first_task) { FactoryBot.create(:first_task, user: first_user) }
    let!(:first_event) { FactoryBot.create(:first_event, task: first_task) }
    let!(:first_task_item) { FactoryBot.create(:first_task_item, task: first_task) }
    let!(:labeling) { FactoryBot.create(:labeling, task: first_task, label: first_label) }
    let!(:second_task) { FactoryBot.create(:second_task, user: first_user) }
    let!(:second_task_item) { FactoryBot.create(:second_task_item, task: second_task) }

    context 'with_labels.search_with_id' do
      it 'Label search is possible' do
        label_ids = Label.pluck(:id)
        tasks = Task.all
        task = tasks.with_labels.search_with_id(label_ids[0])
        expect(task).to include(first_task)
        expect(task).not_to include(second_task)
      end
    end
  end
end