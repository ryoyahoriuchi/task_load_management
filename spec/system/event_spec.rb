require 'rails_helper'

RSpec.describe 'Event function', type: :system do

  let!(:first_user) { FactoryBot.create(:first_user) }

  before do
    visit root_path
    click_link I18n.t('views.link.login')
    fill_in 'user[email]', with: 'jack@mail.com'
    fill_in 'user[password]', with: 'password'
    click_button "ログイン"
    click_link I18n.t('views.link.list_task')
  end

  describe 'Calendar function' do

    before do
      within 'nav' do
        click_link I18n.t('views.link.create_task')
      end
      fill_in 'task[title]', with: 'test_title'
      fill_in 'task[overview]', with: 'test_overview'
      fill_in "task[event_attributes][start_time_on]", with: "002022-04-12"
      fill_in "task[event_attributes][end_time_on]", with: "002022-04-15"
      click_button I18n.t('helpers.submit.create')
      click_button I18n.t('views.button.create')
      click_link I18n.t('views.link.list_task')
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