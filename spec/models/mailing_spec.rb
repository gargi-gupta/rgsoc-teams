require 'spec_helper'

describe Mailing do
  let(:mailing) { Mailing.new(from: 'from@email.com', to: Role::ROLES,
    cc: 'cc@email.com', bcc: 'bcc@email.com', subject: 'subject', body: '# body') }

  it { is_expected.to have_many(:submissions).dependent(:destroy) }

  describe '#sent?' do
    skip 'TODO'
  end

  describe '#submit' do
    it 'should deliver seperate emails to all recipients (incl. cc and bcc)' do
      role = create :coach_role
      mailing.save!
      expect{mailing.submit}.to change{Submission.count}.by(mailing.emails.count)
    end
  end

  describe '#recipients' do
    skip 'TODO'
  end

  describe '#recipient?' do
    let(:user) { FactoryGirl.create(:student) }

    it 'returns false for a an empty recipients list' do
      expect(subject.recipient? user).to be_falsey
    end

    it 'returns true if user has appropriate role' do
      subject.to = %w(students)
      expect(subject.recipient? user).to be_truthy
    end
  end

end
