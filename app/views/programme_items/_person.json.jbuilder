#
#
#
            json.id person.id
            json.first_name person.first_name
            json.last_name person.last_name
            json.suffix person.suffix
            json.pseudonym person.pseudonym
            json.acceptance_status_id person.acceptance_status_id
            json.invitation_category_id person.invitation_category_id
            json.acceptance_status_id person.acceptance_status_id
            json.bio_image person.bio_image if person.bio_image
            json.default_email_address person.getDefaultEmail.present? ? person.getDefaultEmail.email : nil
