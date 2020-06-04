Manager.seed_once do |s|
  s.id = 1
  s.name = Gimei.unique.name.kanji
  s.avatar = Faker::Avatar.image(size: "150x150")
  s.email = "heascook_manager@ahk.jp"
  s.password = "password"
  s.password_confirmation = "password"
end
