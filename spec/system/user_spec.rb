require 'rails_helper'

RSpec.describe 'User function', type: :system do

  let!(:first_user) { FactoryBot.create(:first_user) }
  let!(:third_user) { FactoryBot.create(:third_user) }

  before do
    visit root_path
  end

  describe '新規作成機能' do
    context 'ユーザーを登録したら' do
      it 'ユーザーへ認証メールが送られる' do
        click_link I18n.t('views.link.account_registration')
        fill_in 'user[name]', with: 'test_user'
        fill_in 'user[email]', with: 'test_user@mail.com'
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
        click_button 'アカウント登録'
        expect(page).to have_content '本人確認用のメールを送信しました。メール内のリンクからアカウントを有効化させてください。'
      end
    end
  end

  describe 'ログイン機能' do
    before do
      click_link I18n.t('views.link.login')
    end

    context 'アカウント登録済みのユーザーがログインすると' do
      it 'ユーザー詳細ページへ飛ぶ' do
        fill_in 'user[email]', with: 'jack@mail.com'
        fill_in 'user[password]', with: 'password'
        click_button "ログイン"
        expect(page).to have_content "jack #{I18n.t('views.sentence.page')}"
      end
    end

    context 'ログインせずにアプリページにアクセスすると' do
      it 'ログインページに飛ばされる' do
        visit tasks_path
        expect(current_path).to eq new_user_session_path
        expect(page).to have_content "ログインもしくはアカウント登録してください。"
      end
    end
  end

  describe 'ログアウト機能' do
    context 'ログイン済みユーザーがログアウトすると' do
      it 'アプリページにいけなくなる' do
        click_link I18n.t('views.link.login')
        fill_in 'user[email]', with: 'jack@mail.com'
        fill_in 'user[password]', with: 'password'
        click_button "ログイン"
        visit tasks_path
        expect(current_path).to eq tasks_path
        click_link I18n.t('views.link.logout')
        visit tasks_path
        expect(current_path).not_to eq tasks_path
      end
    end
  end

  describe '編集機能' do
    context 'ユーザー情報を編集すると' do
      it '変更内容がユーザー詳細ページに反映される' do
        click_link I18n.t('views.link.login')
        fill_in 'user[email]', with: 'jack@mail.com'
        fill_in 'user[password]', with: 'password'
        click_button "ログイン"
        expect(page).to have_content "jack #{I18n.t('views.sentence.page')}"
        click_button I18n.t('views.button.mypage_edit')
        fill_in 'user[name]', with: 'jack2'
        fill_in 'user[current_password]', with: 'password'
        click_button "更新"
        expect(page).to have_content 'アカウント情報を変更しました。'
        expect(page).to have_content "jack2 #{I18n.t('views.sentence.page')}"
      end
    end
  end

  describe 'ユーザーアクセス制限機能' do
    context '一般ユーザーは他ユーザーのマイページのurlを入力しても' do
      it '他ユーザーのマイページに飛べない' do
        click_link I18n.t('views.link.login')
        fill_in 'user[email]', with: 'jack@mail.com'
        fill_in 'user[password]', with: 'password'
        click_button "ログイン"
        visit user_path(third_user.id)
        expect(current_path).not_to eq user_path(third_user.id)
        expect(page).to have_content I18n.t('views.messages.unable_to_access_other_user_pages')
      end
    end

    context '管理者は他ユーザーのマイページのurlを入力すると' do
      it '他ユーザーのマイページに飛べる' do
        click_link I18n.t('views.link.login')
        fill_in 'user[email]', with: 'admin_user@mail.com'
        fill_in 'user[password]', with: 'password'
        click_button "ログイン"
        visit user_path(first_user.id)
        expect(current_path).to eq user_path(first_user.id)
      end
    end
  end

  describe '削除機能' do
    context 'アカウントを削除すると' do
      it 'そのアカウントではログインできなくなる' do
        click_link I18n.t('views.link.login')
        fill_in 'user[email]', with: 'jack@mail.com'
        fill_in 'user[password]', with: 'password'
        click_button "ログイン"
        expect(page).to have_content "jack #{I18n.t('views.sentence.page')}"
        click_button I18n.t('views.button.mypage_edit')
        click_button "アカウント削除"
        accept_confirm
        expect(page).to have_content "アカウントを削除しました。またのご利用をお待ちしております。"
        click_link I18n.t('views.link.login')
        fill_in 'user[email]', with: 'jack@mail.com'
        fill_in 'user[password]', with: 'password'
        click_button "ログイン"
        expect(page).to have_content "メールまたはパスワードが違います。"
      end
    end
  end

  describe 'ゲスト機能' do
    context 'ゲストログインボタンを押すと' do
      before do
        click_link I18n.t('views.link.login')
        click_button "ゲストログイン"
      end
      it '一般ユーザーとしてログインできる' do
        expect(page).to have_content I18n.t('views.messages.logged_in_as_guest_user')
        expect(page).to have_content "guest #{I18n.t('views.sentence.page')}"
      end
    end

    context 'ゲスト管理者ログインボタンを押すと' do
      it '管理者としてログインできる' do
        click_link I18n.t('views.link.login')
        click_button "ゲスト管理者ログイン"
        expect(page).to have_content I18n.t('views.messages.logged_in_as_guest_admin_user')
        expect(page).to have_content "guest_admin #{I18n.t('views.sentence.page')}"
      end
    end
  end

  describe '管理者機能' do
    context '管理者が管理者権限のリンクを押すと' do
      it '管理者権限のページへ行ける' do
        click_link I18n.t('views.link.login')
        click_button "ゲスト管理者ログイン"
        click_link I18n.t('views.link.administrator_privileges')
        expect(page).to have_content "ダッシュボード"
      end
    end

    context '一般ユーザーがログインしても' do
      before do
        click_link I18n.t('views.link.login')
        click_button "ゲストログイン"
      end

      it '管理者権限のリンクは表示されない' do
        expect(page).not_to have_link I18n.t('views.link.administrator_privileges')
      end
    end
  end
end