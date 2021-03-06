require 'rails_helper'

RSpec.describe 'Event function', type: :system do
  let!(:first_user) { FactoryBot.create(:first_user) }

  before do
    visit root_path
    click_link I18n.t('views.link.login')
    fill_in 'user[email]', with: 'jack@mail.com'
    fill_in 'user[password]', with: 'password'
    click_button 'ログイン'
    click_link I18n.t('views.link.list_task')
  end

  describe 'Calendar function' do
    before do
      within 'nav' do
        click_link I18n.t('views.link.create_task')
      end

      time = Time.now
      start_time = time.strftime("00%Y-%m-%d")
      end_time = (time + 86_400).strftime("00%Y-%m-%d")

      fill_in 'task[title]', with: 'test_title'
      fill_in 'task[overview]', with: 'test_overview'
      fill_in 'task[event_attributes][start_time_on]', with: start_time
      fill_in 'task[event_attributes][end_time_on]', with: end_time
      click_button I18n.t('views.button.create')
      click_button I18n.t('views.button.create')
      all('main')[0].click_link I18n.t('views.link.list_task')
    end

    context 'Create a new task' do
      it 'The task will be displayed in the calendar' do
        click_link I18n.t('views.link.list_task')
        calendar = find_by_id('calendar')
        expect(calendar).to have_content 'test_title'
      end
    end

    context 'When deleting a task' do
      it 'The task is removed from the calendar' do
        click_button I18n.t('views.button.delete')
        accept_confirm
        calendar = find_by_id('calendar')
        expect(calendar).not_to have_content 'test_title'
      end
    end
  end
end
