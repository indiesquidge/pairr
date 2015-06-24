require "rails_helper"
OmniAuth.config.test_mode = true

RSpec.describe "Dashboard", type: :feature do
  before :each do
    login_helper
  end

  it "should have a shiny button inviting me to 'Find Pairs'" do
    page.visit dashboard_path

    expect(page).to have_selector(:link_or_button, "Find Pairs")
  end

  context "when I click the shiny button" do
    it "I should be shown potential pairs" do
      user = login_helper

      page.visit dashboard_path
      page.click_on "Find Pairs"


      potential_match_id = user.potential_matches.sample
      potential_match    = User.find(potential_match_id)
      expect(page).to have_content(potential_match.login)
    end
  end
end
