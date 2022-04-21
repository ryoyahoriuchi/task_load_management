require 'rails_helper'

RSpec.describe 'Task management function', type: :system do
  let!(:first_user) { FactoryBot.create(:first_user) }
  let!(:first_task) { FactoryBot.create(:first_task, user: first_user) }
  let!(:first_event) { FactoryBot.create(:first_event, task: first_task) }
  let!(:second_task) { FactoryBot.create(:second_task, user: first_user) }
  let!(:second_event) { FactoryBot.create(:second_event, task: second_task) }

  before do
    visit root_path
    click_link I18n.t('views.link.login')
    fill_in 'user[email]', with: 'jack@mail.com'
    fill_in 'user[password]', with: 'password'
    click_button 'ログイン'
    click_link I18n.t('views.link.list_task')
  end

  describe 'New creation function' do
    context 'Create a new task' do
      it 'The created task is displayed' do
        within 'nav' do
          click_link I18n.t('views.link.create_task')
        end
        fill_in 'task[title]', with: 'test_title'
        fill_in 'task[overview]', with: 'test_overview'
        fill_in 'task[event_attributes][start_time_on]', with: '002022-04-12'
        fill_in 'task[event_attributes][end_time_on]', with: '002022-04-15'
        click_button I18n.t('views.button.create')
        click_button I18n.t('views.button.create')
        expect(page).to have_content I18n.t('views.messages.create_task')
        expect(page).to have_content 'test_title'
        expect(page).to have_content 'test_overview'
        expect(page).to have_content '2022-04-12～2022-04-15'
      end
    end
  end

  describe 'List display function' do
    context 'When transitioning to the list screen' do
      it 'A list of created tasks is displayed' do
        expect(page).to have_content 'title01'
        expect(page).to have_content 'overview01'
        expect(page).to have_content 'sample'
        expect(page).to have_content 'summary'
      end
    end
  end

  describe 'Detailed display function' do
    context 'When moving to the task details screen' do
      it 'The content of the corresponding task is displayed' do
        id = all('table tbody tr')
        id[1].click_button I18n.t('views.button.show')
        expect(page).to have_content 'sample'
        expect(page).to have_content 'summary'
        expect(page).to have_content I18n.t('models.enums.underway')
      end
    end
  end

  describe 'Editing function' do
    context 'When editing a task' do
      it 'The content of the corresponding task is changed' do
        id = all('table tbody tr')
        id[0].click_button I18n.t('views.button.edit')
        fill_in 'task[title]', with: 'edited_title'
        fill_in 'task[overview]', with: 'edited_overview'
        select I18n.t('models.enums.completed'), from: 'task[status]'
        click_button I18n.t('views.button.update')
        click_button I18n.t('views.button.create')
        expect(page).to have_content I18n.t('views.messages.updated_task')
        expect(page).to have_content 'edited_title'
        expect(page).to have_content 'edited_overview'
        expect(page).to have_content I18n.t('models.enums.completed')
      end
    end
  end

  describe 'Delete function' do
    context 'If you delete a task' do
      it 'The corresponding task disappears' do
        id = all('table tbody tr')
        expect(page).to have_content 'title01'
        expect(page).to have_content 'overview01'
        id[0].click_button I18n.t('views.button.delete')
        accept_confirm
        expect(page).to have_content I18n.t('views.messages.deleted_task')
        expect(page).not_to have_content 'title01'
        expect(page).not_to have_content 'overview01'
      end
    end
  end
end
