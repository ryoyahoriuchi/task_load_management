require 'rails_helper'

RSpec.describe 'タスク要件機能', type: :system do

  let!(:first_task) { FactoryBot.create(:first_task) }
  let!(:second_task) { FactoryBot.create(:second_task) }
  let!(:first_task_item) { FactoryBot.create(:first_task_item, task: first_task) }
  let!(:second_task_item) { FactoryBot.create(:second_task_item, task: second_task) }

  before do
    visit root_path
  end

  describe '新規作成機能' do
    context 'タスクの新規作成に合わせて要件作成した場合' do
      it '新タスクに合わせて要件が表示される' do
        click_link I18n.t('views.link.create_task')
        fill_in 'task[title]', with: 'title_item'
        fill_in 'task[overview]', with: 'overview_item'
        fill_in 'task[task_items_attributes][0][item]', with: 'test_item'
        select '3', from: 'task[task_items_attributes][0][level]'
        click_button I18n.t('helpers.submit.create')
        click_button I18n.t('views.button.create')
        expect(page).to have_content I18n.t('views.messages.create_task')
        expect(page).to have_content 'title_item'
        expect(page).to have_content 'overview_item'
        expect(page).to have_content 'test_item'
        expect(page).to have_content "#{I18n.t('activerecord.attributes.task_item.level')}:3"
      end
    end

    context 'タスクの新規作成に合わせて複数要件を作成した場合' do
      it '新タスクに合わせて複数要件が表示される' do
        click_link I18n.t('views.link.create_task')
        fill_in 'task[title]', with: 'title_item2'
        fill_in 'task[overview]', with: 'overview_item2'
        fill_in 'task[task_items_attributes][0][item]', with: 'test_item2'
        select '4', from: 'task[task_items_attributes][0][level]'
        click_link I18n.t('views.link.add_task_item')
        id = all('body form div div input')
        select_id = all('body form div div select')
        id[1].fill_in with: 'sample_item3'
        select_id[1].select '5'
        click_button I18n.t('helpers.submit.create')
        click_button I18n.t('views.button.create')
        expect(page).to have_content I18n.t('views.messages.create_task')
        expect(page).to have_content 'test_item2'
        expect(page).to have_content "#{I18n.t('activerecord.attributes.task_item.level')}:4"
        expect(page).to have_content 'sample_item3'
        expect(page).to have_content "#{I18n.t('activerecord.attributes.task_item.level')}:5"
      end
    end
  end

  describe '詳細表示機能' do
    context '任意の詳細画面に遷移した場合' do
      it '該当タスクに登録した要件が表示される' do
        id = all('table tbody tr')
        id[0].click_button I18n.t('views.button.show')
        expect(page).to have_content 'title01'
        expect(page).to have_content 'item01'
        expect(page).to have_content "#{I18n.t('activerecord.attributes.task_item.level')}:1"
      end
    end
  end

  describe '編集機能' do
    context '任意のタスクに合わせてタスクアイテムを編集する場合' do
      it '該当タスクアイテムの内容が変更される' do
        id = all('table tbody tr')
        id[1].click_button I18n.t('views.button.edit')
        fill_in 'task[task_items_attributes][0][item]', with: 'edited item'
        select '9', from: 'task[task_items_attributes][0][level]'
        binding.irb #不具合発生update出来てない
        click_button I18n.t('helpers.submit.update')
        click_button I18n.t('views.button.create')
        expect(page).to have_content 'sample'
        expect(page).to have_content 'edited item'
        expect(page).to have_content "#{I18n.t('activerecord.attributes.task_item.level')}:9"
      end
    end

    context '任意のタスクにタスクアイテムを追加する場合' do
      it '該当タスクに追加したアイテムが表示される' do
      end
    end
  end

  describe '削除機能' do
    context '任意のタスクに登録したタスクアイテムを削除した場合' do
      it '該当タスクアイテムのみ削除される' do
      end
    end
  end
end