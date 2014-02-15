class MailTemplate < ActiveRecord::Base
  has_enumerated :mail_use, :class_name => 'MailUse'
  has_enumerated :transiton_invite_status, :class_name => 'InviteStatus' # the status that a person transistions too after the mail is sent out
  
  belongs_to :survey
  has_many :mailings

  before_destroy :check_for_mailings

  def as_json(options={})
    res = super()

    res['mail_use'] = mail_use.name  
        
    return res
  end

private

  # we  want to check that this has not been used by a mailing
  def check_for_mailings
    if mailings.any?
      # errors.add :base, "can not delete a template that is being used in a mailing"
      raise "can not delete a template that is being used in a mailing"
    end
  end

end
