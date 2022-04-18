require 'rails_helper'

RSpec.describe 'Task item function', type: :system do

  let!(:first_user) { FactoryBot.create(:first_user) }
  let!(:first_task) { FactoryBot.create(:first_task, user: first_user) }
  let!(:second_task) { FactoryBot.create(:second_task, user: first_user) }
  let!(:first_event) { FactoryBot.create(:first_event, task: first_task) }
  let!(:second_event) { FactoryBot.create(:second_event, task: second_task) }
  let!(:first_task_item) { FactoryBot.create(:first_task_item, task: first_task) }
  let!(:second_task_item) { FactoryBot.create(:second_task_item, task: second_task) }

  before do
    visit root_path
    click_link I18n.t('views.link.login')
    fill_in 'user[email]', with: 'jack@mail.com'
    fill_in 'user[password]', with: 'password'
    click_button "ログイン"
    click_link I18n.t('views.link.list_task')
  end

  describe 'New creation function' do
    context 'When an item is created accoding to the creation of a new task' do
      it 'Items will be displayed according to the new task' do
        within 'nav' do
          click_link I18n.t('views.link.create_task')
        end
        fill_in 'task[title]', with: 'title_item'
        fill_in 'task[overview]', with: 'overview_item'
        fill_in "task[event_attributes][start_time_on]", with: "002022-04-12"
        fill_in "task[event_attributes][end_time_on]", with: "002022-04-15"
        fill_in 'task[task_items_attributes][0][item]', with: 'test_item'
        select '3', from: 'task[task_items_attributes][0][level]'
        click_button I18n.t('views.button.create')
        click_button I18n.t('views.button.create')
        expect(page).to have_content I18n.t('views.messages.create_task')
        expect(page).to have_content 'title_item'
        expect(page).to have_content 'overview_item'
        expect(page).to have_content 'test_item'
        expect(page).to have_content "#{I18n.t('activerecord.attributes.task_item.level')}:3"
      end
    end

    context 'When multiple items are created in response to the creation of a new task' do
      it 'New task presents multiple items' do
        within 'nav' do
          click_link I18n.t('views.link.create_task')
        end
        fill_in 'task[title]', with: 'title_item2'
        fill_in 'task[overview]', with: 'overview_item2'
        fill_in "task[event_attributes][start_time_on]", with: "002022-04-12"
        fill_in "task[event_attributes][end_time_on]", with: "002022-04-15"
        fill_in 'task[task_items_attributes][0][item]', with: 'test_item2'
        select '4', from: 'task[task_items_attributes][0][level]'
        click_link I18n.t('views.link.add_task_item')
        id = all('body form div div input')
        select_id = all('body form div div select')
        id[1].fill_in with: 'sample_item3'
        select_id[1].select '5'
        click_button I18n.t('views.button.create')
        click_button I18n.t('views.button.create')
        expect(page).to have_content I18n.t('views.messages.create_task')
        expect(page).to have_content 'test_item2'
        expect(page).to have_content "#{I18n.t('activerecord.attributes.task_item.level')}:4"
        expect(page).to have_content 'sample_item3'
        expect(page).to have_content "#{I18n.t('activerecord.attributes.task_item.level')}:5"
      end
    end
  end

  describe 'Detailed display function' do
    context 'When moving to the task details screen' do
      it 'Items registered in the task are displayed' do
        id = all('table tbody tr')
        id[0].click_button I18n.t('views.button.show')
        expect(page).to have_content 'title01'
        expect(page).to have_content 'item01'
        expect(page).to have_content "#{I18n.t('activerecord.attributes.task_item.level')}:1"
      end
    end
  end

  describe 'Editing function' do
    context 'When editing a task item for a task' do
      it 'The content of the corresponding task item is changed' do
        id = all('table tbody tr')
        id[1].click_button I18n.t('views.button.edit')
        fill_in 'task[task_items_attributes][0][item]', with: 'edited item'
        select '9', from: 'task[task_items_attributes][0][level]'
        click_button I18n.t('views.button.update')
        click_button I18n.t('views.button.create')
        expect(page).to have_content 'sample'
        expect(page).to have_content 'edited item'
        expect(page).to have_content "#{I18n.t('activerecord.attributes.task_item.level')}:9"
      end
    end

    context 'When adding a task item to any task' do
      it 'Items added to the task are displayed' do
        id = all('table tbody tr')
        id[1].click_button I18n.t('views.button.edit')
        2.times { click_link I18n.t('views.link.add_task_item') }
        id = all(".nested-fields")
        id[1].fill_in with: 'item2'
        id[1].select '9'
        id[2].fill_in with: 'item3'
        id[2].select '8'
        click_button I18n.t('views.button.update')
        click_button I18n.t('views.button.create')
        expect(page).to have_content I18n.t('views.messages.updated_task')
        expect(page).to have_content 'sample'
        expect(page).to have_content 'issue02'
        expect(page).to have_content "#{I18n.t('activerecord.attributes.task_item.level')}:2"
        expect(page).to have_content 'item2'
        expect(page).to have_content "#{I18n.t('activerecord.attributes.task_item.level')}:9"
        expect(page).to have_content 'item3'
        expect(page).to have_content "#{I18n.t('activerecord.attributes.task_item.level')}:8"
      end
    end

    context 'When a task item in a task is deleted' do
      it 'Only the corresponding task item will be deleted' do
        id = all('table tbody tr')
        id[1].click_button I18n.t('views.button.edit')
        click_link I18n.t('views.link.remove_task_item')
        click_button I18n.t('views.button.update')
        click_button I18n.t('views.button.create')
        expect(page).not_to have_content 'issue02'
        expect(page).not_to have_content "#{I18n.t('activerecord.attributes.task_item.level')}:2"
      end
    end
  end
end