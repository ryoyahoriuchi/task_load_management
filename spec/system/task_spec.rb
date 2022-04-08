require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :system do

  let!(:first_task) { FactoryBot.create(:first_task) }
  let!(:second_task) { FactoryBot.create(:second_task) }

  before do
    visit root_path
  end

  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成されたタスクが表示される' do
        click_link I18n.t('views.link.create_task')
        fill_in 'task[title]', with: 'test_title'
        fill_in 'task[overview]', with: 'test_overview'
        click_button I18n.t('helpers.submit.create')
        click_button I18n.t('views.button.create')
        expect(page).to have_content I18n.t('views.messages.create_task')
      end
    end
  end

  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        expect(page).to have_content "title01"
        expect(page).to have_content "overview01"
        expect(page).to have_content "sample"
        expect(page).to have_content "summary"
      end
    end
  end

  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        id = all('table tbody tr')
        id[1].click_button I18n.t('views.button.show')
        expect(page).to have_content "sample"
        expect(page).to have_content "summary"
        expect(page).to have_content I18n.t('models.enums.underway')
      end
    end
  end

  describe '編集機能' do
    context '任意のタスクを編集した場合' do
      it '該当タスクの内容が変更される' do
        id = all('table tbody tr')
        id[0].click_button I18n.t('views.button.edit')
        fill_in 'task[title]', with: 'edited_title'
        fill_in 'task[overview]', with: 'edited_overview'
        select I18n.t('models.enums.completed'), from: 'task[status]'
        click_button I18n.t('helpers.submit.update')
        click_button I18n.t('views.button.create')
        expect(page).to have_content I18n.t('views.messages.updated_task')
        expect(page).to have_content "edited_title"
        expect(page).to have_content "edited_overview"
        expect(page).to have_content I18n.t('models.enums.completed')
      end
    end
  end

  describe '削除機能' do
    context '任意のタスクを削除した場合' do
      it '該当タスクが表示されなくなる' do
        id = all('table tbody tr')
        expect(page).to have_content "title01"
        expect(page).to have_content "overview01"
        id[0].click_button I18n.t('views.button.delete')
        expect(page).to have_content I18n.t('views.messages.deleted_task')
        expect(page).not_to have_content "title01"
        expect(page).not_to have_content "overview01"
      end
    end
  end
end