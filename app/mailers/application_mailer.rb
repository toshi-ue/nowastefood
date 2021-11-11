# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'NoWasteFood <info@nowastefood.tk>'
  layout 'mailer'
end
