class PersonMailingAssignment < ActiveRecord::Base
  attr_accessible :lock_version, :person_id, :mailing_id
  
  belongs_to  :person
  belongs_to  :mailing
  
  has_many  :mail_histories

end
