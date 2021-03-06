RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end

def mock_omniauth_user
  OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
    "provider" => "github",
    "uid"      => "123456",
    "extra" => {
      "raw_info" => {
        "login"      => "mock_user",
        "avatar_url" => "mock_user_thumbnail_url"
      }
    },
    "credentials" => {
      "token" => "mock_token"
    }
  })
end

def login_helper
  page.visit root_path
  user = User.find_or_create_from_auth(mock_omniauth_user)

  within "nav" do
    page.click_on "Login"
  end
  other_user1 = User.create!(login: "other_user1")
  user.potential_matches << other_user1.id
  user.save!

  user
end
