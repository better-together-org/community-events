json.totalpages @nbr_pages
json.currpage @page
json.totalrecords @count
json.currentSelection @currentId if @currentId
    
json.rowdata @people do |person|

    
    json.id person.id
    json.set! "person[prefix]", person.prefix
    json.set! "person[first_name]", person.first_name
    json.set! "person[last_name]", person.last_name
    json.set! "person[suffix]", person.suffix
    json.set! "person[comments]", person.comments if person.comments
    json.set! "person[organization]", (person.company ? person.company : '')
    
    json.set! "person[acceptance_status_id]", person.acceptance_status ? person.acceptance_status.name : AcceptanceStatus[:Unknown].name
    json.set! "person[invitestatus_id]", person.invitestatus ? person.invitestatus.name : InviteStatus['Not Set'].name
    json.set! "person[invitation_category_id]", person.invitation_category ? person.invitation_category.name : ''
    json.set! "person[lock_version]", person.lock_version
    
    if person.pseudonym
            json.set! "person[pseudonym_attributes][prefix]", person.pseudonym.prefix 
            json.set! "person[pseudonym_attributes][first_name]", person.pseudonym.first_name 
            json.set! "person[pseudonym_attributes][last_name]", person.pseudonym.last_name
            json.set! "person[pseudonym_attributes][suffix]", person.pseudonym.suffix
    end
    
    if @includeMailings
        json.set! "person[mailings]", person.mailings
    end

    if @includeMailHistory
        json.set! "person[mail_history]", person.mail_histories.collect{|h| h.testrun ? nil : (h.mailing ? h.mailing.mailing_number.to_s + ' - ' + h.mailing.mail_template.title : nil) }.compact
    end
    
    json.set! "person[has_survey]", SurveyService.personHasSurveys( person) ? "Y" : "N"
    
    json.set! "default_email", person.getDefaultEmail

    json.set! "email_addresses", person.email_addresses.collect{|e| (!e.email.blank?) ? e.email : nil }.compact
    
    json.set! "person[reg_type]",   person.registrationDetail ? person.registrationDetail.registration_type : ''
    json.set! "person[reg_nbr]",   person.registrationDetail ? person.registrationDetail.registration_number : ''

end
