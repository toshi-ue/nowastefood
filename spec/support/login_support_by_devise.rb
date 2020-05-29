module LoginSupportByDevise
  def sign_in_as_manager(manager)
    visit_root_path
    click_link "管理者としてログイン"
    fill_in "Email", with: manager.email
    fill_in "Password", with: manager.password
  end
end

# Rspec.configure do |config|
#   # config.include LoginSupportByDevise
#   config.include LoginSupport
# end
