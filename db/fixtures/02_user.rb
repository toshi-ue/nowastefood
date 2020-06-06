# [faker/name.md at master · faker-ruby/faker](https://github.com/faker-ruby/faker/blob/master/doc/default/name.md)

User.seed_once do |s|
  s.id = 1
  s.nickname = Faker::Creature::Horse.name
  s.avatar = Faker::Avatar.image(slug: "my-own-slug", size: "150x150")
  s.email = "heascook_user@ahk.jp"
  s.password = "password"
  s.password_confirmation = "password"
end
