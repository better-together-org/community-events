class Participants::ParticipantListCell < Cell::Rails

  def display(args)
    @place = args.has_key?(:place) ? args[:place] : "participants"
    @pager = args.has_key?(:pager) ? args[:pager] : 'pager'
    render
  end
  
  def javascript(args)
    @place = args.has_key?(:place) ? args[:place] : "participants"
    @caption = args.has_key?(:caption) ? args[:caption] : "participants"
    @selectNotifyMethod = args.has_key?(:selectNotifyMethod) ? args[:selectNotifyMethod] : "function() {}"
    @clearNotifyMethod = args.has_key?(:clearNotifyMethod) ? args[:clearNotifyMethod] : "function() {}"
    @loadNotifyMethod = args.has_key?(:loadNotifyMethod) ? args[:loadNotifyMethod] : "function() {}"
    @pager = args.has_key?(:pager) ? args[:pager] : 'pager'
    @root_url = baseUri + (args.has_key?(:root_url) ? args[:root_url] : "/")
    @baseUrl = args.has_key?(:baseUrl) ? args[:baseUrl] : "participants"
    @getGridData = args.has_key?(:getGridData) ? args[:getGridData] : "/getList.json"
    
    @invite_status = args.has_key?(:invite_status) ? args[:invite_status] : true
    @invite_category = args.has_key?(:invite_category) ? args[:invite_category] : true
    @acceptance_status = args.has_key?(:acceptance_status) ? args[:acceptance_status] : true
    @has_survey = args.has_key?(:has_survey) ? args[:has_survey] : true
    @reg_type = args.has_key?(:reg_type) ? args[:reg_type] : true
    @organization = args.has_key?(:organization) ? args[:organization] : true
    
    @view = args.has_key?(:view) ? args[:view] : false
    @search = args.has_key?(:search) ? args[:search] : false
    @del = args.has_key?(:del) ? args[:del] : true
    @edit = args.has_key?(:edit) ? args[:edit] : true
    @add = args.has_key?(:add) ? args[:add] : true
    @refresh = args.has_key?(:refresh) ? args[:refresh] : false
    @controlDiv = args.has_key?(:controlDiv) ? args[:controlDiv] : 'participant-control'
    
    @extraClause = args.has_key?(:extraClause) ? args[:extraClause] : nil
    @includeMailings = args.has_key?(:includeMailings) ? args[:includeMailings] : false
    @includeMailHistory = args.has_key?(:includeMailHistory) ? args[:includeMailHistory] : false
    
    @multiselect = args.has_key?(:multiselect) ? args[:multiselect] : false
    @multiboxonly = args.has_key?(:multiboxonly) ? args[:multiboxonly] : false
    @hide_select_all = args.has_key?(:hide_select_all) ? args[:hide_select_all] : false
    
    @onlySurveyRespondents = args.has_key?(:onlySurveyRespondents) ? args[:onlySurveyRespondents] : false
    
    @modelType = args.has_key?(:modelType) ? args[:modelType] : 'null'
    @modelTemplate = args.has_key?(:modelTemplate) ? args[:modelTemplate] : ""
    @showControls = args.has_key?(:showControls) ? args[:showControls] : false
    
    @extra_button = args.has_key?(:extra_button) ? args[:extra_button] : false
    @extra_button_title = args.has_key?(:extra_button_title) ? args[:extra_button_title] : ""
    @extra_modal_action = args.has_key?(:extra_modal_action) ? args[:extra_modal_action] : "function() {}"

    
    @delayed = args.has_key?(:delayed) ? args[:delayed] : false
    
    render
  end

end
