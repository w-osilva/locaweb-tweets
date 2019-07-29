require 'rails_helper'

describe Twitter::Tweets, type: :service do

  describe '.LOCAWEB_USER_ID' do
    it { expect(described_class::LOCAWEB_USER_ID).to be 42 }
  end

  describe '.include modules' do
    it { expect(described_class.included_modules.include?(Twitter::Concerns::TweetsFormat)).to be true  }
    it { expect(described_class.included_modules.include?(Twitter::Concerns::TweetsSort)).to be true  }
  end

  describe '#all' do
    let(:response) { VCR.use_cassette("tweeps.locaweb.com.br/tweeps") { Twitter::Api.singleton.get } }

    it 'get data from api and filter tweets based on rules' do
      expect(Twitter::Api.singleton).to receive(:get).and_return(response)
      expect(subject).to receive(:filter_locaweb_mentions)
      expect(subject).to receive(:remove_replies_to_locaweb)
      subject.all
    end
  end

  describe '#filter_locaweb_mentions' do
    let(:response) { VCR.use_cassette("tweeps.locaweb.com.br/tweeps") { Twitter::Api.singleton.get } }

    it 'select tweets where user_mentions_id is equal to LOCAWEB_USER_ID' do
      tweets = subject.filter_locaweb_mentions(response['statuses'])
      tweets.each do |t|
        expect(t['entities']['user_mentions'][0]['id'].to_i).to be described_class::LOCAWEB_USER_ID
      end
    end
  end

  describe '#remove_replies_to_locaweb' do
    let(:response) { VCR.use_cassette("tweeps.locaweb.com.br/tweeps") { Twitter::Api.singleton.get } }

    it 'reject tweets where in_reply_to_user_id is equal to LOCAWEB_USER_ID' do
      tweets = subject.remove_replies_to_locaweb(response['statuses'])
      tweets.each do |t|
        expect(t["in_reply_to_user_id"].to_i).not_to be described_class::LOCAWEB_USER_ID
      end
    end
  end

  describe '#most_relevants' do
    it 'sort tweets and format content based on most_relevants' do
      allow(subject).to receive(:all).and_return([])
      expect(subject).to receive(:format_most_relevants)
      expect(subject).to receive(:sort_most_relevants)
      subject.most_relevants
    end
  end

  describe '#most_mentions' do
    it 'sort tweets and format content based on most_mentions' do
      allow(subject).to receive(:all).and_return([])
      expect(subject).to receive(:format_most_mentions)
      expect(subject).to receive(:sort_most_mentions)
      subject.most_mentions
    end
  end

end