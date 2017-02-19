
    json.id                         person.id
    json.prefix                     person.prefix 
    json.first_name                 person.first_name 
    json.last_name                  person.last_name
    json.suffix                     person.suffix
    json.has_pseudonym              (person.pseudonym ? true : false)
    if person.pseudonym
        json.pseudonym do
            json.prefix             person.pseudonym.prefix if person.pseudonym.prefix
            json.first_name         person.pseudonym.first_name if person.pseudonym.first_name
            json.last_name          person.pseudonym.last_name if person.pseudonym.last_name
            json.suffix             person.pseudonym.suffix if person.pseudonym.suffix
            json.lock_version       person.pseudonym.lock_version
        end
    end
    json.full_publication_name      person.getFullPublicationName
    json.company                    person.company
    json.job_title                  person.job_title
    json.survey_key                 person.survey_respondent ?  person.survey_respondent.key : "" 
    json.invitestatus_id            person.invitestatus.id if @person.invitestatus
    json.invitestatus_name          person.invitestatus ? @person.invitestatus.name : ""
    json.acceptance_status_id       person.acceptance_status.id if @person.acceptance_status
    json.acceptance_status_name     person.acceptance_status ? @person.acceptance_status.name : ""
    json.invitation_category_id     person.invitation_category.id if @person.invitation_category
    json.invitation_category_name   person.invitation_category ? @person.invitation_category.name : ""
    json.has_survey                 SurveyService.personAnsweredSurvey( person, 'partsurvey') ? 'Y' : 'N' # TODO - this will need to change
    json.comments                   person.comments ? person.comments : ""
    json.bio_image                  person.bio_image if person.bio_image
    json.lock_version               person.lock_version
    json.email_address              person.getDefaultEmail.present? ? person.getDefaultEmail.email : nil
    json.default_email_address      person.getDefaultEmail
    