# frozen_string_literal: true

require 'active_record'
require "fileutils"
require 'date'

t = Time.current
t_folder_name = t.strftime("%y%m%d")
seed_gen_folder = "#{Rails.root}/db/afixtures"

model_names_image_exists = %w[cuisine user]

namespace :seed_fu_gen do
  desc "back up datas to folder named \"#{seed_gen_folder}/#{t_folder_name}\"."
  task all: :environment do |_t|
    # add or clean directory
    if Dir.exist?(seed_gen_folder)
      if Dir.exist?("#{seed_gen_folder}/#{t_folder_name}")
        Dir.chdir("#{seed_gen_folder}/#{t_folder_name}")
        FileUtils.rm(Dir.glob('*.rb'))
        model_names_image_exists.each do |ms|
          Dir.chdir("#{seed_gen_folder}/#{t_folder_name}/uploads/#{ms}/")
          FileUtils.rm(Dir.glob('*.*'))
        end
        Dir.chdir(Rails.root.to_s)
      else
        model_names_image_exists.each do |ms|
          FileUtils.mkdir_p("#{seed_gen_folder}/#{t_folder_name}/uploads/#{ms}")
        end
      end
    end

    # 01_manager.rb
    managers = Manager.all
    SeedFu::Writer.write("db/afixtures/#{t_folder_name}/01_manager.rb", class_name: 'Manager', seed_type: :seed_once) do |writer|
      managers.find_each do |mg|
        writer << mg.attributes.except("current_sign_in_at", "last_sign_in_at", "created_at", "updated_at")
      end
    end

    # 02_user.rb
    users = User.all
    SeedFu::Writer.write("db/afixtures/#{t_folder_name}/02_user.rb", class_name: "User", seed_type: :seed_once) do |writer|
      users.each do |user|
        FileUtils.cp("#{Rails.root}/public#{user.profile_image}", "#{Rails.root}/db/afixtures/#{t_folder_name}#{user.profile_image}")
        user.profile_image = File.new("#{Rails.root}/public#{user.profile_image}")
        writer << user.attributes.except("current_sign_in_at", "last_sign_in_at", "created_at", "updated_at")
      end
    end

    # 03_foodcategory.rb
    foodcategories = Foodcategory.all
    SeedFu::Writer.write("db/afixtures/#{t_folder_name}/03_foodcategory.rb", class_name: "Foodcategory", seed_type: :seed_once) do |writer|
      foodcategories.each do |fc|
        writer << fc.attributes.except("created_at", "updated_at")
      end
    end

    # 04_unit.rb
    units = Unit.all
    SeedFu::Writer.write("db/afixtures/#{t_folder_name}/04_unit.rb", class_name: "Unit", seed_type: :seed_once) do |writer|
      units.each do |ut|
        writer << ut.attributes.except("created_at", "updated_at")
      end
    end

    # 06_rawmaterial.rb
    rawmaterials = Rawmaterial.all
    SeedFu::Writer.write("db/afixtures/#{t_folder_name}/06_rawmaterial.rb", class_name: "Rawmaterial", seed_type: :seed_once) do |writer|
      rawmaterials.each do |rm|
        writer << rm.attributes.except("created_at", "updated_at")
      end
    end

    # 21_cuisine.rb
    cuisines = Cuisine.all
    SeedFu::Writer.write("db/afixtures/#{t_folder_name}/21_cuisine.rb", class_name: "Cuisine", seed_type: :seed_once) do |writer|
      cuisines.each do |cn|
        FileUtils.cp("#{Rails.root}/public#{cn.main_image}", "#{Rails.root}/db/afixtures/#{t_folder_name}#{cn.main_image}")
        cn.main_image = File.new("#{Rails.root}/public#{cn.main_image}")
        # FIXME: カラム値が代入されない
        # cn.cooking_time = Cuisine.cooking_times[cn.cooking_time]
        # cn.genre = Cuisine.genres[cn.genre]
        # cn.status = Cuisine.statuses[cn.status]
        writer << cn.attributes.except("created_at", "updated_at")
      end
    end

    # 22_foodstuff.rb
    foodstuffs = Foodstuff.all
    SeedFu::Writer.write("db/afixtures/#{t_folder_name}/22_foodstuff.rb", class_name: "Foodstuff", seed_type: :seed_once) do |writer|
      foodstuffs.each do |fs|
        writer << fs.attributes.except("created_at", "updated_at")
      end
    end

    # 23_procedure.rb
    procedures = Procedure.all
    SeedFu::Writer.write("db/afixtures/#{t_folder_name}/23_procedure.rb", class_name: "Procedure", seed_type: :seed_once) do |writer|
      procedures.each do |pd|
        writer << pd.attributes.except("created_at", "updated_at")
      end
    end
  end
end

namespace :seed_fu_all_datas do
  desc 'create seed files and images'
  task all: :environment do |_t|
    # find latest foloder name
    folder_names = []
    Dir.glob("#{Rails.root}/db/afixtures/*") do |f|
      folder_names << f.slice(/[0-9]+$/).to_i
    end
    latest_folder_name = folder_names.max.to_s

    # copy image files
    model_names_image_exists.each do |ms|
      target_folder = "#{Rails.root}/public/uploads/#{ms}"
      # remove jpg files of target_folder
      if Dir.exist?(target_folder)
        Dir.chdir(target_folder)
        FileUtils.rm(Dir.glob('*.jpg'))
      else
        FileUtils.mkdir_p(target_folder)
      end
      Dir.chdir("#{seed_gen_folder}/#{latest_folder_name}/uploads/#{ms}/")
      # duplicate jpg files
      Dir.glob('*') do |item|
        FileUtils.cp(item, target_folder.to_s)
      end
    end

    # re:make seed folder and files
    should_re_change_folder = "#{Rails.root}/db/fixtures"
    FileUtils.rm_rf(should_re_change_folder)
    # FileUtils.mkdir_p(should_re_change_folder)

    FileUtils.cp_r("#{Rails.root}/db/afixtures/#{latest_folder_name}", should_re_change_folder)
    FileUtils.cp_r("#{Rails.root}/db/afixtures/#{latest_folder_name}/uploads", "#{Rails.root}/public/uploads")
    # "#{Rails.root}/db/afixtures/*"
  end
end

namespace :change_properties_to_adapt_seed_data do
  desc 'change properties of profile_image and main_image'
  task all: :environment do |_t|
    # usersテーブル用
    target_file = Rails.root.join("db/fixtures/02_user.rb")
    buffer = File.read(target_file)

    buffer.gsub!(/"profile_image"=>"/, "\"profile_image\"=>Rails.root.join(\"db/fixtures/uploads/user/")
    buffer.gsub!(/\.jpg"/, ".jpg\").open")
    File.write(target_file, buffer)

    # cuisinesテーブル用
    target_file = Rails.root.join("db/fixtures/21_cuisine.rb")
    buffer = File.read(target_file)

    buffer.gsub!(/"main_image"=>"/, "\"main_image\"=>Rails.root.join(\"db/fixtures/uploads/cuisine/")
    buffer.gsub!(/\.jpg"/, ".jpg\").open")

    # FIXME: 特定の文字列を数値に変換できない
    # enum(cooking_time)
    # buffer.gsub!(/\"lt_minutes5\"/, 5)
    # buffer.gsub!(/\"lt_minutes10\"/, 10)
    # buffer.gsub!(/\"lt_minutes20\"/, 20)
    # buffer.gsub!(/\"gt_minutes21\"/, 21)
    # # enum(genre)
    # buffer.gsub!(/\"japanese\"/, 1)
    # buffer.gsub!(/\"western\"/, 2)
    # buffer.gsub!(/\"chinese\"/, 3)
    # buffer.gsub!(/\"other\"/, 4)
    # # enum(status)
    # buffer.gsub!(/\"draft\"/, 0)
    # buffer.gsub!(/\"published\"/, 1)

    File.write(target_file, buffer)
  end
end
