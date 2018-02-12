class SitemapsController < ApplicationController
  def show
    @jobs = Job.where(published: true).where.not(visible_until: nil).newest_first
    respond_to do |format|
      format.xml
    end
  end
end
