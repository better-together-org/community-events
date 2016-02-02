class ProgramPlannerController < PlannerController
  include ProgramPlannerHelper
  #
  #
  #
  def assignments
    rooms = params[:rooms] ? params[:rooms].split(',').collect{|a| a.to_i} : nil
    @day = params[:day] # Day
    if rooms
      @roomListing = Room.unscoped.where(where_clause).all :order => 'venues.sort_order asc, venues.name asc, rooms.sort_order asc, rooms.name asc',
                            :conditions => ["rooms.id in (?)", rooms],
                            :joins => :venue
    else
      @roomListing = Room.unscoped.where(where_clause).all :order => 'venues.sort_order asc, venues.name asc, rooms.sort_order asc, rooms.name asc',
                            :joins => :venue
    end
    site_config = SiteConfig.first
    @currentDate = Time.zone.parse(site_config.start_date.to_s) + @day.to_i.day
  end

  #
  # Add an item to a room
  #
  def addItem
    begin
      ProgrammeItem.transaction do
        @assignment = nil
        if !params[:cancel]
          item = ProgrammeItem.find(params[:itemid])
          room = Room.find(params[:roomid])
          day = params[:day]
          time = params[:time].to_time # The start time

          @assignment = addItemToRoomAndTime(item, room, day, time)
        end

        render :layout => 'content'
      end
    rescue => ex
      render status: :bad_request, text: ex.message
    end
  end

  #
  # Unschedule an item
  #
  def removeItem
    begin
      ProgrammeItem.transaction do
        item = ProgrammeItem.find(params[:itemid])

        removeAssignment(item.room_item_assignment)

        render status: :ok, text: {}.to_json
      end
    rescue => ex
      render status: :bad_request, text: ex.message
    end
  end

  #
  #
  #
  def getConflicts
    @day = params[:day]

    @conflicts = ProgramItemsService.getItemConflicts(@day)
    @roomConflicts = ProgramItemsService.getRoomConflicts(@day)
    @excludedItemConflicts = ProgramItemsService.getExcludedItemConflicts(@day)
    @excludedTimeConflicts = ProgramItemsService.getExcludedTimeConflicts(@day)
    @availableTimeConflicts = ProgramItemsService.getAvailabilityConficts(@day)
    @backtobackConflicts = ProgramItemsService.getBackToBackConflicts(@day)
  end

  protected
  
  def where_clause
    true
  end

end
