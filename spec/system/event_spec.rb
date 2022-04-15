require 'rails_helper'

RSpec.describe 'Event function', type: :system do

  before do
    visit root_path
  end

  describe 'Calendar function' do

    before do
      click_link I18n.t('views.link.create_task')
      fill_in 'task[title]', with: 'test_title'
      fill_in 'task[overview]', with: 'test_overview'
      fill_in "task[event_attributes][start_time_on]", with: "002022-04-12"
      fill_in "task[event_attributes][end_time_on]", with: "002022-04-15"
      click_button I18n.t('helpers.submit.create')
      click_button I18n.t('views.button.create')
      click_link I18n.t('views.link.back')
    end

    context 'Create a new task' do
      it 'The task will be displayed in the calendar' do
        calendar = find_by_id("calendar")
        expect(calendar).to have_content 'test_title'
      end
    end

    context 'When deleting a task' do
      it 'The task is removed from the calendar' do
        click_button I18n.t('views.button.delete')
        calendar = find_by_id("calendar")
        expect(calendar).not_to have_content 'test_title'
      end
    end
  end
end