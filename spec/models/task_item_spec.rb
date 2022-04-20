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
end
