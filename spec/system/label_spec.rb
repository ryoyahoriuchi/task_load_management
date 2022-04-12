require 'rails_helper'

RSpec.describe 'Label function', type: :system do

  let!(:first_label) { FactoryBot.create(:first_label) }
  let!(:second_label) { FactoryBot.create(:second_label) }
  let!(:third_label) { FactoryBot.create(:third_label) }
  let!(:first_task) { FactoryBot.create(:first_task) }
  let!(:first_event) { FactoryBot.create(:first_event, task: first_task) }
  let!(:first_task_item) { FactoryBot.create(:first_task_item, task: first_task) }

  before do
    visit root_path
  end

  describe 'Label mounting function' do
    context 'Can be labeled when creating a task' do
      it 'Labels are displayed according to the task' do
        click_link I18n.t('views.link.create_task')
        fill_in 'task[title]', with: 'title_test'
        fill_in "task[event_attributes][start_time_on]", with: "002022-04-12"
        fill_in "task[event_attributes][end_time_on]", with: "002022-04-15"
        fill_in 'task[overview]', with: 'overview_test'
        fill_in 'task[task_items_attributes][0][item]', with: 'item_test'
        check 'blue'
        click_button I18n.t('helpers.submit.create')
        click_button I18n.t('views.button.create')
        expect(page).to have_content I18n.t('views.messages.create_task')
        expect(page).to have_content 'blue'
      end
    end

    context 'Can add multiple labels when creating a task' do
      it 'Multiple labels are displayed depending on the task' do
        click_link I18n.t('views.link.create_task')
        fill_in 'task[title]', with: 'title_test'
        fill_in 'task[overview]', with: 'overview_test'
        fill_in "task[event_attributes][start_time_on]", with: "002022-04-12"
        fill_in "task[event_attributes][end_time_on]", with: "002022-04-15"
        fill_in 'task[task_items_attributes][0][item]', with: 'item_test'
        check 'blue'
        check 'green'
        click_button I18n.t('helpers.submit.create')
        click_button I18n.t('views.button.create')
        expect(page).to have_content I18n.t('views.messages.create_task')
        expect(page).to have_content 'blue'
        expect(page).to have_content 'green'
      end
    end
  end

  describe 'Label editing function' do
    before do
      click_button I18n.t('views.button.edit')
      check 'red'
      click_button I18n.t('helpers.submit.update')
      click_button I18n.t('views.button.create')
    end
    context 'When the label associated with the task is edited' do
      it 'The corresponding label is also displayed additionally' do
        expect(page).to have_content 'red'
      end
    end
    
    context 'When the label associated with the task is deleted' do
      it 'The corresponding label is not displayed' do
        expect(page).to have_content 'red'
        click_link I18n.t('views.button.back')
        click_button I18n.t('views.button.edit')
        check 'red'
        click_button I18n.t('helpers.submit.update')
        click_button I18n.t('views.button.create')
        expect(page).to have_content 'red'
      end
    end
  end

  describe 'Label search function' do
    let!(:second_task) { FactoryBot.create(:second_task) }
    let!(:second_event) { FactoryBot.create(:second_event, task: second_task) }
    let!(:second_task_item) { FactoryBot.create(:second_task_item, task: second_task) }
    let!(:third_task) { FactoryBot.create(:third_task) }
    let!(:third_event) { FactoryBot.create(:third_event, task: third_task) }
    let!(:third_task_item) { FactoryBot.create(:third_task_item, task: third_task) }
    before do
      visit root_path
      id = all('table tbody tr')
      id[0].click_button I18n.t('views.button.edit')
      check 'red'
      click_button I18n.t('helpers.submit.update')
      click_button I18n.t('views.button.create')
      click_link I18n.t('views.link.back')
      id = all('table tbody tr')
      id[1].click_button I18n.t('views.button.edit')
      check 'red'
      check 'blue'
      click_button I18n.t('helpers.submit.update')
      click_button I18n.t('views.button.create')
      click_link I18n.t('views.link.back')
    end
    context 'When searching by selecting a label' do
      it 'Only the corresponding label list is displayed' do
        check 'red'
        click_button I18n.t('activerecord.attributes.label.search')
        table = all('table tbody tr')
        expect(table[0]).to have_content 'title01'
        expect(table[1]).to have_content 'sample'
        check 'blue'
        click_button I18n.t('activerecord.attributes.label.search')
        table = all('table tbody tr')
        expect(table[0]).to have_content 'sample'
        check 'green'
        click_button I18n.t('activerecord.attributes.label.search')
        table = all('table tbody')
        expect(table).not_to have_content 'title01'
        expect(table).not_to have_content 'sample'
        expect(table).not_to have_content 'ruby'
      end
    end
  end

end