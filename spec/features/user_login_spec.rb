require "rails_helper"
OmniAuth.config.test_mode = true

RSpec.describe "As a new user", type: :feature do
  context "when I first access the site" do
    it "I should be prompted to log in with GitHub" do
      page.visit root_path
      mock_omniauth_user

      expect(page).to have_content("Login with GitHub")
    end

    it "I should not be able to access the dashboard until I log in" do
      page.visit dashboard_path

      expect(page.current_path).to eq(root_path)
      expect(page).to have_content("Login required")
    end
  end

  context "the first time I log in" do
    it "I should be asked about my 'user information'" do
      Language.create!(name: "Ruby")
      Language.create!(name: "Java")
      login_helper

      page.fill_in "user-description", with: "I love code"
      page.find("input#Ruby").set(true)
      page.find("input#Java").set(false)
      page.find_button("Update info", disabled: true).click

      expect(page).to have_content("Ruby")
      expect(page).to have_content("I love code")
      expect(page).not_to have_content("Java")
    end
  end

  context "the second time I log in" do
    it "I should not be asked about my 'user information'" do
      Language.create!(name: "Ruby")
      Language.create!(name: "Java")
      login_helper

      page.find("input#Ruby").set(true)
      page.find("input#Java").set(false)
      page.find_button("Update info", disabled: true).click

      page.click_on "Logout"
      page.click_on "Login with GitHub"
      expect(page).to have_content("Welcome")
    end
  end
end
