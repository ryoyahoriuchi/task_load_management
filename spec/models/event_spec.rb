require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'Event function', type: :model do
    task = Task.new(title: 'sample1', overview: 'sample1')

    context 'No start_time_on entered' do
      it 'Get caught in validation' do
        event = Event.new(start_time_on: '', end_time_on: '2022-04-13', task: task)
        expect(event).not_to be_valid
      end
    end

    context 'No end_time_on entered' do
      it 'Get caught in validation' do
        event = Event.new(start_time_on: '2022-04-12', end_time_on: '', task: task)
        expect(event).not_to be_valid
      end
    end

    context 'Set end_time_on to the date before start_time_on' do
      it 'Get caught in validation' do
        event = Event.new(start_time_on: '2022-04-20', end_time_on: '2022-04-13', task: task)
        expect(event).not_to be_valid
      end
    end

    context 'start_time_on and end_time_on are entered correctly' do
      it 'Pass the validation' do
        event = Event.new(start_time_on: '2022-04-12', end_time_on: '2022-04-13', task: task)
        expect(event).to be_valid
      end
    end
  end
end
