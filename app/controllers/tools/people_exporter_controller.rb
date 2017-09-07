class Tools::PeopleExporterController < PlannerController
  
  def export
    invitestatus_id = params[:invitestatus_id].to_i > 0 ? params[:invitestatus_id].to_i : nil
    invitation_category_id = params[:invitation_category_id].to_i > 0 ? params[:invitation_category_id].to_i : nil
    
    # limit to people in this event ...
    only_relevent = params[:only_relevent] != 'true'

    # Get the people (batch), filter by invite status and category
    @people = PeopleService.findAllPeople invitestatus_id, invitation_category_id, only_relevent
  
    # output as an Excel file
    response.headers['Content-Disposition'] = 'attachment; filename="people_' + Time.now.strftime("%m-%d-%Y") + '.xlsx"'
  end
  
end
