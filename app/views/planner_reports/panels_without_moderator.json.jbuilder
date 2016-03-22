
json.totalpages 1
json.currpage 1
    
json.rowdata @panels.collect { |panel|
    count = panel.programme_item_assignments.length
    
    panel
}.compact do |panel|
    json.pub_reference_number panel.pub_reference_number
    json.title panel.title + (panel.parent ? " [" + panel.parent.title  + "]" : '')
    json.description panel.precis
    json.minimum_people panel.minimum_people
    json.maximum_people panel.maximum_people
    json.format (panel.format ? panel.format.name : '')
    json.context panel.taggings.collect{|t| t.context}.uniq
    if panel.time_slot
        json.start_time panel.time_slot.start.strftime('%a %H:%M')
        json.end_time panel.time_slot.end.strftime('%a %H:%M')
        json.room_name panel.room.name if panel.room
        json.venue_name panel.room.venue.name if panel.room
    elsif panel.parent
        json.start_time panel.parent.time_slot.start.strftime('%a %H:%M')
        json.end_time panel.parent.time_slot.end.strftime('%a %H:%M')
        json.room_name panel.parent.room.name if panel.parent.room
        json.venue_name panel.parent.room.venue.name if panel.parent.room
    end
    
    json.participants panel.programme_item_assignments.select{|pi| pi.role == PersonItemRole['Participant']}.collect {|p| p.person.getFullPublicationName + (!p.person.company.blank? ? ' (' + p.person.company + ')' : '')}
    json.moderators panel.programme_item_assignments.select{|pi| pi.role == PersonItemRole['Moderator']}.collect {|p| p.person.getFullPublicationName + (!p.person.company.blank? ? ' (' + p.person.company + ')' : '')}
    json.reserve panel.programme_item_assignments.select{|pi| pi.role == PersonItemRole['Reserved']}.collect {|p| p.person.getFullPublicationName + (!p.person.company.blank? ? ' (' + p.person.company + ')' : '')}
    json.invisible panel.programme_item_assignments.select{|pi| pi.role == PersonItemRole['Invisible']}.collect {|p| p.person.getFullPublicationName + (!p.person.company.blank? ? ' (' + p.person.company + ')' : '')}
end
