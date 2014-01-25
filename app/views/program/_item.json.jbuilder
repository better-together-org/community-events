
json.id         item.id    
json.title      item.title    
json.desc       item.precis
json.mins       item.duration
json.day        item.published_room_item_assignment.day
json.date       item.published_time_slot.start.strftime('%Y-%m-%d')
json.time       item.published_time_slot.start.strftime('%H:%M')
json.datetime   item.published_time_slot.start
json.loc        [item.published_room_item_assignment.published_room.name, item.published_room_item_assignment.published_room.published_venue.name]
json.people     item.people.each do |person| 
    json.partial! 'person', person: person
    # TODO - we need the role
end