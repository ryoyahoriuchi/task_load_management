require 'rails_helper'

RSpec.describe 'Label function', type: :system do

  let!(:first_label) { FactoryBot.create(:first_label) }
  let!(:second_label) { FactoryBot.create(:second_label) }
  let!(:third_label) { FactoryBot.create(:third_label) }
  let!(:first_task) { FactoryBot.create(:first_task) }
  let!(:first_task_item) { FactoryBot.create(:first_task_item, task: first_task) }

  before do
    visit root_path
  end

  describe 'ラベル取付機能' do
    context 'タスク作成に伴いラベルを取り付けられる' do
      it 'ラベルが表示される' do
        click_link I18n.t('views.link.create_task')
        fill_in 'task[title]', with: 'title_test'
        fill_in 'task[overview]', with: 'overview_test'
        fill_in 'task[task_items_attributes][0][item]', with: 'item_test'
        check 'blue'
        click_button I18n.t('helpers.submit.create')
        click_button I18n.t('views.button.create')
        expect(page).to have_content I18n.t('views.messages.create_task')
        expect(page).to have_content 'blue'
      end
    end

    context 'タスク作成に伴い複数ラベルを取り付けられる' do
      it '複数ラベルが表示される' do
        click_link I18n.t('views.link.create_task')
        fill_in 'task[title]', with: 'title_test'
        fill_in 'task[overview]', with: 'overview_test'
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

  describe 'ラベル編集機能' do
    before do
      click_button I18n.t('views.button.edit')
      check 'red'
      click_button I18n.t('helpers.submit.update')
      click_button I18n.t('views.button.create')
    end
    context 'タスクに紐づいているラベルを取付編集をした場合' do
      it '該当ラベルも追加で表示される' do
        expect(page).to have_content 'red'
      end
    end
    
    context 'タスクに紐づいているラベルを取り外した場合' do
      it '該当ラベルは表示されなくなる' do
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

  describe 'ラベル検索機能' do
    let!(:second_task) { FactoryBot.create(:second_task) }
    let!(:second_task_item) { FactoryBot.create(:second_task_item, task: second_task) }
    let!(:third_task) { FactoryBot.create(:third_task) }
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
    context 'ラベルを選択して検索する場合' do
      it '該当するラベルのみ表示される' do
        check 'red'
        click_button I18n.t('activerecord.attributes.label.search')
        expect(page).to have_content 'title01'
        expect(page).to have_content 'sample'
        expect(page).not_to have_content 'ruby'
        check 'blue'
        click_button I18n.t('activerecord.attributes.label.search')
        expect(page).not_to have_content 'title01'
        expect(page).to have_content 'sample'
        expect(page).not_to have_content 'ruby'
        check 'green'
        click_button I18n.t('activerecord.attributes.label.search')
        expect(page).not_to have_content 'title01'
        expect(page).not_to have_content 'sample'
        expect(page).not_to have_content 'ruby'
      end
    end
  end

end