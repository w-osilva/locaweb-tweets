require 'rails_helper'

RSpec.describe Twitter::Api, type: :service do

  describe ".singleton" do
    subject(:object) { described_class.singleton }
    it "always return the same object" do
      expect(object).to eq(described_class.singleton)
    end
    it "an object of class" do
      expect(object.class).to eq(Twitter::Api)
    end
    it "set object with global variable '$twitter_config'" do
      expect(object.url).to eq($twitter_config[:url])
      expect(object.username).to eq($twitter_config[:username])
    end
  end

  describe ".new" do
    it "set attribute url" do
      expect(described_class.new(url: 'url').url).not_to be nil
    end
    it "set attribute username" do
      expect(described_class.new(username: 'username').username).not_to be nil
    end
    it "set attribute header" do
      expect(described_class.new.header).not_to be nil
    end
  end

  describe "getters and setters" do
    context "attr_reader" do
      it { should have_attr_reader(:response) }
    end
    context "attr_accessor" do
      it { should have_attr_accessor(:url) }
      it { should have_attr_accessor(:username) }
      it { should have_attr_accessor(:header) }
    end
  end

  describe "#get" do
    it "use RestClient to make the request"
    it "set attribute response"
    it "parse response.body to JSON"
  end
end