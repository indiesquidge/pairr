json = ActiveSupport::JSON.decode(File.read("db/seeds/sample_users.json"))

all_languages = json.first["languages"].keys
all_languages.each do |language|
  Language.create!(name: language)
  puts "generated language #{language}"
end

json.each do |data|
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
