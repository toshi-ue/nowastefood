# frozen_string_literal: true

class RawmaterialMailer < ApplicationMailer
  def notify_new_rawmaterial(rawmaterial)
    @rawmaterial = rawmaterial
    mail(to: ENV['TOMAIL'], subject: "#{@rawmaterial.name} が追加されました")
  end
end
