module Mailgpg
  module MailHandlerPatch
    def receive(raw_mail, options={})
      mail = raw_mail
      encrypted = false
      signature_valid = false

      if raw_mail.encrypted?
        encrypted = true
        mail = raw_mail.decrypt(:verify => true)
        if mail.verify.signature_valid?
          signature_valid = true
        end
      elsif mail.signed? && mail.verify.signature_valid?
        signature_valid = true
      end

      nosig = mail.without_attachments!

      mail.attachments do |attachment|
        unless attachment == "signature.asc"
          nosig.attachments[attachments.filename] = attachment
        end
      end

      super nosig, options
    end
  end
end
