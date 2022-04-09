require 'rails_helper'

RSpec.describe Memo, type: :model do
  describe 'Memo function', type: :model do

    task = Task.new(title: "sample1", overview: "sample1")
    task_item = TaskItem.new(item: "item1", level: 1, task: task)

    context 'No content entered' do
      it 'Get caught in validation' do
        memo = Memo.new(content: "", task_item: task_item)
        expect(memo).not_to be_valid
      end
    end

    context 'Content is entered' do
      it 'Pass the validation' do
        memo = Memo.new(content: "content2", task_item: task_item)
        expect(memo).to be_valid
      end
    end
  end
end