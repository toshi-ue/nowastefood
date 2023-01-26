# https://ja.stackoverflow.com/questions/22060/rails%E3%81%A7%E6%97%A2%E5%AD%98%E3%82%AF%E3%83%A9%E3%82%B9%E3%81%B8%E3%81%AE%E3%83%A1%E3%82%BD%E3%83%83%E3%83%89%E8%BF%BD%E5%8A%A0%E3%82%92%E3%81%99%E3%82%8B%E6%99%82%E3%81%AE%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%81%AE%E7%BD%AE%E3%81%8D%E5%A0%B4%E6%89%80
# https://qiita.com/azusanakano/items/885fe3236977580b00c9
# https://zenn.dev/isao_e_dev/articles/4707c522b20af0
class EnFaker
  include Faker
  EnFaker::Config.locale = :en
end
