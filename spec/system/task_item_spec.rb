require 'rails_helper'

RSpec.describe 'タスク要件機能', type: :system do

  let!(:first_task) { FactoryBot.create(:first_task) }
  let!(:second_task) { FactoryBot.create(:second_task) }

  before do
    visit root_path
  end

  describe '新規作成機能' do
    context 'タスクの新規作成に合わせて要件作成した場合' do
      it '新タスクに合わせて要件が表示される' do
      end
    end

    context 'タスクの新規作成に合わせて複数要件を作成した場合' do
      it '新タスクに合わせて複数要件が表示される' do
      end
    end
  end

  describe '詳細表示機能' do
    context '任意の詳細画面に遷移した場合' do
      it '該当タスクに登録した要件が表示される' do
      end
    end
  end

  describe '編集機能' do
    context '任意のタスクに合わせてタスクアイテムを編集する場合' do
      it '該当タスクアイテムの内容が変更される' do
      end
    end 
  end
end