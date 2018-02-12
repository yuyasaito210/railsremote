require 'spec_helper'

describe Job do
  describe "#token" do
    it "is generated on create" do
      job = Job.create!
      expect(job.token).to be_present
    end
  end

  describe "#expired?" do
    it "is true if the visible_until is present and in the past" do
      expect(Job.new(visible_until: 1.day.ago)).to          be_expired
      expect(Job.new(visible_until: 1.day.from_now)).to_not be_expired
      expect(Job.new(visible_until: nil)).to_not            be_expired
    end
  end
end
