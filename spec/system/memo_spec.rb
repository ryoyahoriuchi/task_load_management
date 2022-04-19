require 'rails_helper'

RSpec.describe 'Memo function', type: :system do
  let!(:first_user) { FactoryBot.create(:first_user) }
  let!(:first_task) { FactoryBot.create(:first_task, user: first_user) }
  let!(:second_task) { FactoryBot.create(:second_task, user: first_user) }
  let!(:first_event) { FactoryBot.create(:first_event, task: first_task) }
  let!(:second_event) { FactoryBot.create(:second_event, task: second_task) }
  let!(:first_task_item) { FactoryBot.create(:first_task_item, task: first_task) }
  let!(:second_task_item) { FactoryBot.create(:second_task_item, task: second_task) }
  let!(:first_memo) { FactoryBot.create(:first_memo, task_item: first_task_item) }

  before do
    visit root_path
    click_link I18n.t('views.link.login')
    fill_in 'user[email]', with: 'jack@mail.com'
    fill_in 'user[password]', with: 'password'
    click_button 'ログイン'
    click_link I18n.t('views.link.list_task')
  end

  describe 'New creation function' do
    context 'When creating a memo' do
      it 'The created memo is displayed' do
        id = all('table tbody tr')
        id[1].click_button I18n.t('views.button.show')
        fill_in 'memo[content]', with: 'Hallo!'
        click_button I18n.t('helpers.submit.create')
        expect(page).to have_content 'Hallo!'
      end
    end
  end

  describe 'Editing function' do
    context 'When editing a memo' do
      it 'The edited memo is displayed' do
        id = all('table tbody tr')
        id[0].click_button I18n.t('views.button.show')
        expect(page).to have_content 'content01'
        click_button I18n.t('views.button.memo_edit')
        sleep 0.1
        memo_id = all('textarea')
        memo_id[0].fill_in with: 'edited'
        click_button I18n.t('helpers.submit.update')
        expect(page).to have_content I18n.t('views.messages.edited_memo')
        expect(page).not_to have_content 'content01'
        expect(page).to have_content 'edited'
      end
    end
  end

  describe 'Delete function' do
    context 'When deleting a memo' do
      it 'The corresponding memo disappears' do
        id = all('table tbody tr')
        id[0].click_button I18n.t('views.button.show')
        expect(page).to have_content 'content01'
        click_button I18n.t('views.button.memo_delete')
        accept_confirm
        expect(page).to have_content I18n.t('views.messages.deleted_memo')
        expect(page).not_to have_content 'content01'
      end
    end
  end
end
