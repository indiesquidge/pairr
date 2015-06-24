class Seed
  USER_JSON = ActiveSupport::JSON.decode(File.read("db/seeds/sample_users.json"))

  def call
    generate_languages
    generate_users
  end

  def generate_languages
    all_languages = USER_JSON.first["languages"].keys
    all_languages.each do |language|
      Language.create!(name: language)
      puts "generated language #{language}"
    end
  end

  def generate_users
    USER_JSON.each do |data|
      user = User.create!(
        login: data["login"],
        avatar_url: data["avatar_url"],
        description: data["description"],
      )
      preferred_languages = data["languages"]
      preferred_languages.each do |lang, choice|
        if choice == 1
          language = Language.find_by(name: lang)
          Userlanguage.create!(user_id: user.id, language_id: language.id)
          puts "#{user.login} prefers #{lang}"
        end
      end
    end
  end

  def generate_potential_matches
    all_users = User.all
    all_users.each do |user|
      all_users.each do |u|
        unless u.id == user.id
          user.potential_matches << u.id
          puts "generated potential match #{u.login} for #{user.login}"
        end
        user.potential_matches.shuffle!
        user.save!
      end
    end
  end

  def self.call
    new.call
  end
end

Seed.call
