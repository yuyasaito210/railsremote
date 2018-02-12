require 'spec_helper'

feature "Job" do
  scenario "when previewing a new one and then publishing" do
    visit 'jobs/new'
    fill_in_info_about_dev_job

    click_button 'Preview'

    expect(page).to have_content 'Junior Developer'
    expect(page).to have_content 'is a preview'

    click_link 'Edit the Job'

    fill_in 'job_title', with: 'Senior Developer'
    click_button 'Save and Continue'

    expect(page).to have_content 'Senior Developer'
    expect(page).to have_content 'public'
  end

  scenario "when posting a new one without previewing" do
    visit 'jobs/new'
    fill_in_info_about_dev_job
    click_button 'Save and Continue'

    expect(page).to have_content 'All done!'
    expect(page).to have_content 'Junior Developer'
  end
end

def fill_in_info_about_dev_job
  within '.test-job-form' do
    fill_in 'job_title', with: 'Junior Developer'
    fill_in 'job_company_name', with: 'Awesome company'
  end
end
