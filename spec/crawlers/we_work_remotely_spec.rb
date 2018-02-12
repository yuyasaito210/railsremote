require 'spec_helper'

describe WeWorkRemotely do
  class FixtureFetch
    def initialize(url)
    end

    def doc
      Nokogiri.parse File.open(File.join(Rails.root, 'spec', 'support', 'fixtures', 'we_work_remotely.html'), 'r').read
    end
  end

  describe '#to_h' do
    it 'extracts relevant fields' do
      hash = described_class.new('https://weworkremotely.com/jobs/1171', fetcher_class: FixtureFetch).to_h
      expect(hash[:title]).to eq("Ruby Developer")
      expect(hash[:company_name]).to eq("Stack Builders")
      expect(hash[:company_url]).to eq("www.stackbuilders.com")
      expect(hash[:description]).to start_with("**About Us**\n")
      expect(hash[:how_to_apply]).to start_with("Send a resume to careers@stackbuilders.com")
    end
  end
end
