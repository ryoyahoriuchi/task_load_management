require 'rails_helper'

RSpec.describe TaskItem, type: :model do
  describe 'Task item function', type: :model do
    task = Task.new(title: 'sample1', overview: 'sample1')

    context 'No item entered' do
      it 'Get caught in validation' do
        task_item = TaskItem.new(item: '', level: 1, task: task)
        expect(task_item).not_to be_valid
      end
    end

    context 'Item is entered' do
      it 'Pass the validation' do
        task_item = TaskItem.new(item: 'item2', level: 2, task: task)
        expect(task_item).to be_valid
      end
    end
  end

  describe 'scope' do
    let!(:first_user) { FactoryBot.create(:first_user) }
    let!(:first_task) { FactoryBot.create(:first_task, user: first_user) }
    let!(:third_task_item) { FactoryBot.create(:third_task_item, task: first_task, created_at: Date.today + 3.days) }
    let!(:second_task_item) { FactoryBot.create(:second_task_item, task: first_task, created_at: Date.today + 2.days) }
    let!(:first_task_item) { FactoryBot.create(:first_task_item, task: first_task, created_at: Date.today + 1.days) }

    context 'create_sorted' do
      it 'Sorted in order of creation' do
        expect(TaskItem.pluck(:item)).to match ['problem', 'issue02', 'item01']
        expect(TaskItem.create_sorted.pluck(:item)).to match ['item01', 'issue02', 'problem']
      end
    end
  end
end
