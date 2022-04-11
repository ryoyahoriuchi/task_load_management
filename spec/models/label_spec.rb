require 'rails_helper'

RSpec.describe Label, type: :model do
  describe 'Label function', type: :model do

    context 'No genre entered' do
      it 'Get caught in validation' do
        label = Label.new(genre: "")
        expect(label).not_to be_valid
      end
    end

    context 'Entered more than 10 characters in the genre' do
      it 'Get caught in validation' do
        label = Label.new(genre: "a" * 11)
        expect(label).not_to be_valid
      end
    end

    context 'genre is entered' do
      it 'Pass the validation' do
        label = Label.new(genre: "sample")
        expect(label).to be_valid
      end
    end
  end
end