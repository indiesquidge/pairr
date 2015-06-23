require "rails_helper"
OmniAuth.config.test_mode = true

RSpec.describe "As a new user", type: :feature do
  context "when I first access the site" do
    it "I should be prompted to log in with GitHub" do
      page.visit root_path
      user = mock_omniauth_user

      page.click_on "Login with GitHub"

      expect(page).to have_content(user.name)
    end
  end

  context "the first time I log in" do
    it "I should be asked about my 'user information'"
  end

  context "the second time I log in" do
    it "I should not be asked about my 'user information'"
  end
end
