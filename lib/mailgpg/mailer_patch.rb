module Mailgpg
  module MailerPatch
    def mail(headers={}, &block)
      [:to, :cc, :bcc].each do |recipient|
        if headers[recipient].present?
          unless GPGME::Key.find(:public, headers[recipient]).empty?
            headers[:gpg] = { :encrypt => true, :sign => true }
          end
        end
      end

      super headers, &block
    end
  end
end

