class Mailing < ActiveRecord::Base
  attr_accessible :lock_version, :testrun, :scheduled, :mailing_number, :mail_template_id, :last_person_idx, :include_email, :cc_all
  
  has_many  :person_mailing_assignments
  has_many  :people, :through => :person_mailing_assignments
  
  belongs_to :mail_template
  
  validate :number_and_mail_use_unique
  
  def as_json(options={})
    res = super()

    res['mail_use'] = mail_template ? mail_template.mail_use.name : ''
        
    return res
  end

  
  def number_and_mail_use_unique
    # Make sure that the combination of number and mail_use_id is unique
    m = Mailing.first :conditions => ["mailing_number = ? AND mail_templates.mail_use_id = ?", mailing_number, mail_template.mail_use_id], :joins => :mail_template
    errors.add(:mailing_number, I18n.t("planner.core.errors.unique-mailing-error")) if m != nil && m.id != id
  end
end
