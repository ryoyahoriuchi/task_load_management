require "rails_helper"

RSpec.describe NoticeMailer, type: :mailer do
  let!(:first_user) { FactoryBot.create(:first_user) }
  let!(:first_task) { FactoryBot.create(:first_task, user: first_user) }
  let!(:first_event) { FactoryBot.create(:first_event, task: first_task) }

  describe "sendmail_start_task" do
    context 'start_mail' do
      let(:mail) { NoticeMailer.sendmail_start_task(first_task) }
      ActionMailer::Base.deliveries.last

      it "renders the headers" do
        expect(mail.subject).to eq I18n.t('mail.start_contact')
        expect(mail.to).to eq(["jack@mail.com"])
        expect(mail.from).to eq([ENV['EMAIL']])
      end

      it "renders the body" do
        expect(mail.body.encoded).to have_content I18n.t('mail.start_contact_sentence')
        expect(mail.body.encoded).to have_content I18n.t('mail.request_start')
      end
    end
  end

  describe "sendmail_deadline_task" do
    context 'deadline_mail' do
      let(:mail) { NoticeMailer.sendmail_deadline_task(first_task) }
      ActionMailer::Base.deliveries.last
      it "renders the headers" do
        expect(mail.subject).to eq I18n.t('mail.dead_contact')
        expect(mail.to).to eq(["jack@mail.com"])
        expect(mail.from).to eq([ENV['EMAIL']])
      end

      it "renders the body" do
        expect(mail.body.encoded).to have_content I18n.t('mail.dead_contact_sentence')
        expect(mail.body.encoded).to have_content I18n.t('mail.request_end')
      end
    end
  end
end
