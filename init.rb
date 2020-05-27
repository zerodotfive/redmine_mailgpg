require 'gpgme'
require 'mail-gpg'
require 'mail_handler'

Redmine::Plugin.register :mailgpg do
  name 'Mailgpg plugin'
  author 'Zerodotfive'
  description 'Mail encryption/decryption plugin'
  version '0.0.1'
  url 'https://github.com/zerodotfive/redmine_mailgpg'
  author_url 'https://github.com/zerodotfive/'
end

Rails.configuration.to_prepare do
  unless ActionMailer::Base.ancestors.include? Mailgpg::MailerPatch
    ActionMailer::Base.send(:prepend, Mailgpg::MailerPatch)
  end

  unless MailHandler.ancestors.include? Mailgpg::MailHandlerPatch
    MailHandler.send(:prepend, Mailgpg::MailHandlerPatch)
  end
end
