class SurveyQueryController < PlannerController
  
  def index
    @queries = SurveyQuery.all
  end
  
  def list
    conditions = {}
    conditions = { "user_id" => @current_user.id } if params[:subset] && (params[:subset] == 'user')
    conditions = { "shared" => true } if params[:subset] && (params[:subset] == 'shared')
    
    @queries = SurveyQuery.all :conditions => conditions
  end

  def questions
    survey = SurveyQuery.find(params[:survey])
    
    surveyId = survey.survey_id
    
    # TODO - use the group and question ordering
    questions = SurveyQuestion.all :joins => {:survey_group => :survey}, :include => :survey_answers,
                :conditions => {:surveys => {:id => surveyId}, :question_type => ['textfield', 'textbox', 'singlechoice', 'multiplechoice', 'selectionbox', 'availability']}
    
    render json: questions.to_json(:only => [ :id, :name, :question, :question_type, :mandatory, :answer_type, :isbio, :survey_group, :sort_order, :answer ],
                                  :include => {:survey_answers => {}}
                                ), :content_type => 'application/json'
  end

  def show
    @query = SurveyQuery.find(params[:id])
  end
  
  def create
    # TODO - make sure name is unique
    begin
      SurveyQuery.transaction do
        @query = SurveyQuery.new(params[:survey_query]) # and then save the query
        @query.user = @current_user
        if @query.save!
          @query.update_predicates(params[:survey_query_predicates]) if params[:survey_query_predicates]
        end
      end
    rescue Exception
      raise
    end
  end

  def update
    begin
      SurveyQuery.transaction do
        # get the survey
        @query = SurveyQuery.find(params[:id])

        # and then update it's attributes
        @query.update_attributes!(params[:survey_query])
        if params[:survey_query_predicates]
          @query.update_predicates(params[:survey_query_predicates])
        else # clear out the answers
          @query.survey_query_predicates.delete_all
        end
      end
    rescue Exception
      raise
    end
  end

  def destroy
    query = SurveyQuery.find(params[:id])
    
    # Test to make sure that the person requesting the delete owns the query
    if (query.user == @current_user)
      query.destroy
      render status: :ok, text: {}.to_json
    else
      render status: :bad_request, text: 'Con not delete query owned by another user'
    end
  end

end
