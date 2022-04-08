require 'rails_helper'

RSpec.describe 'タスクメモ機能', type: :system do

  let!(:first_task) { FactoryBot.create(:first_task) }
  let!(:second_task) { FactoryBot.create(:second_task) }

  before do
    visit root_path
  end

  describe '新規作成機能' do
    context 'メモを作成した場合' do
      it '作成したメモが表示される' do
      end
    end
  end

  describe '編集機能' do
    context 'メモを編集した場合' do
      it '編集したメモが表示される' do
      end
    end
  end

  describe '削除機能' do
    context 'メモを削除した場合' do
      it '該当メモが表示されなくなる' do
      end
    end
  end
end