# == Schema Information
#
# Table name: polls
#
#  id            :integer          not null, primary key
#  title         :string           not null
#  description   :text             not null
#  closing_date  :date             not null
#  user_id       :integer
#  totals        :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  poll_image    :string
#  active        :boolean          default(TRUE)
#  poll_document :string
#

require 'rails_helper'

RSpec.describe Poll, type: :model do
  describe 'relations' do
    it { should belong_to(:user) }
    it { should have_many(:vote_types) }
    it { should have_many(:votes) }
    it { should have_many(:debates) }
    it { should have_many(:external_links) }
    it { should accept_nested_attributes_for(:vote_types) }
  end

  describe 'validations' do
    let(:poll) { FactoryGirl.create(:poll) }
    it 'should validate closing_date' do
      poll.update(closing_date: Date.today - 3.days)
      poll.valid?
      expect(poll.errors[:closing_date].empty?).to be false
    end
    let(:poll) { FactoryGirl.create(:poll) }
    it 'should validate at least one tag selected' do
      poll.valid?
      expect(poll.errors[:at_least_one_tag].empty?).to be false
    end
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:closing_date) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:poll_image) }
    it { should validate_presence_of(:poll_document) }
  end

  describe 'named scopes' do
    let(:poll_1) { FactoryGirl.create(:poll, closing_date: Date.today - 3.days) }
    let(:poll_2) { FactoryGirl.create(:poll, closing_date: Date.today + 3.days) }
    let(:poll_3) { FactoryGirl.create(:poll, closing_date: Date.today + 3.days, active: false) }
    describe 'active' do
      it 'returns only polls that are active and non closed' do
        expect(Poll.active).to include(poll_2)
        expect(Poll.active).not_to include(poll_1, poll_3)
      end
    end
    describe 'inactive' do
      it 'returns only polls that are inactive or closed' do
        expect(Poll.inactive).not_to include(poll_2)
        expect(Poll.inactive).to include(poll_1, poll_3)
      end
    end
  end

  describe 'poll#closed?' do
    let(:poll) { FactoryGirl.build(:poll, closing_date: Date.today - 3.days) }
    context 'when poll closing date has passed' do
      it 'returns true' do
        expect(poll.closed?).to eq(true)
      end
    end
    context 'when poll closing date has not passed yet' do
      it 'returns false' do
        poll.update(closing_date: Date.today + 3.days)
        expect(poll.closed?).to eq(false)
      end
    end
  end

  describe 'poll#set_tags()' do
    let(:poll) { FactoryGirl.create(:poll) }
    let(:tag_1) { FactoryGirl.create(:tag) }
    let(:tag_2) { FactoryGirl.create(:tag) }
    let(:tag_3) { FactoryGirl.create(:tag) }
    context 'when coma separated tag names are passed as argument to the method' do
      it 'adds tags to poll' do
        poll.set_tags("#{tag_1.name},#{tag_3.name}")
        expect(poll.tags).to match_array([tag_1, tag_3])
      end
      it 'adds the right amount of tags' do
        poll.set_tags("#{tag_1.name},#{tag_3.name}")
        expect(poll.tags.count).to eq 2
      end
    end
    context 'when a tag is not passed as argument to the method' do
      it 'should not add the tag' do
        poll.set_tags("#{tag_1.name},#{tag_3.name}")
        expect(poll.tags).not_to include(tag_2)
      end
    end
  end

  describe 'poll#published_debates?' do
    let(:poll) { FactoryGirl.create(:poll_with_votes_and_debates) }
    context 'when poll has not published debates' do
      it 'returns an empty array' do
        expect(poll.published_debates).to eq([])
      end
    end
    context 'when poll has published debates' do
      it 'returns only publshed debates' do
        debates = poll.debates
        debates.first.update(published: true)
        debates.last.update(published: true)
        expect(poll.published_debates).to include(debates.first, debates.last)
      end
    end
  end

  describe 'Poll.by_status()' do
    let(:poll_1) { FactoryGirl.create(:poll, closing_date: Date.today - 3.days) }
    let(:poll_2) { FactoryGirl.create(:poll, closing_date: Date.today + 3.days) }
    let(:poll_3) { FactoryGirl.create(:poll, closing_date: Date.today + 3.days, active: false) }
    context 'when the passed status is inactive' do
      it 'returns inactive polls' do
        expect(Poll.by_status("inactive")).to match_array([poll_1, poll_3])
      end
    end
    context 'when the passed status is active' do
      it 'returns active polls' do
        expect(Poll.by_status("active")).to match_array(poll_2)
      end
    end
  end
end