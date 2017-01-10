class SurveyQueryController < PlannerController
  
  def index
    @queries = SurveyQuery.all
  end
  
  def list
    conditions = {}
    conditions = { "user_id" => @current_user.id, "shared" => false } if params[:subset] && (params[:subset] == 'user' && !support_user_signed_in?)
    conditions = { "shared" => true } if params[:subset] && (params[:subset] == 'shared')
    
    @queries = SurveyQuery.where(conditions)
  end

  def questions
    query = SurveyQuery.find(params[:survey_query]) if params[:survey_query]
    survey = Survey.find(params[:survey]) if params[:survey]
    
    surveyId = query.survey_id if query
    surveyId = survey.id if survey
    
    # TODO - use the group and question ordering
    @questions = SurveyQuestion.references(:survey_answers).
                    joins({:survey_group => :survey}).
                    includes(:survey_answers).
                    where({:surveys => {:id => surveyId}, :question_type => ['textfield', 'textbox', 'singlechoice', 'multiplechoice', 'selectionbox', 'availability']})

  end

  def show
    @query = SurveyQuery.find(params[:id])
  end
  
  def create
    # TODO - make sure name is unique
    begin
      SurveyQuery.transaction do
        raise "can not create query as a support user" if support_user_signed_in?
        @query = SurveyQuery.new(params[:survey_query]) # and then save the query
        @query.user = @current_user
        if @query.save!
          @query.update_predicates(params[:survey_query_predicates]) if params[:survey_query_predicates]
        end
      end
    rescue => ex
      render status: :bad_request, text: ex.message
    end
  end

  def update
    begin
      SurveyQuery.transaction do
        raise "can not edit query as a support user" if support_user_signed_in?
        # get the survey
        @query = SurveyQuery.find(params[:id])

        # and then update it's attributes
        @query.update_attributes!(params[:survey_query])
        if params[:survey_query_predicates]
          params[:survey_query_predicates].each do |predicate|
            predicate.delete(:survey_question_name) # survey_question_name, survey_question_type
            predicate.delete(:survey_question_type) # survey_question_name, survey_question_type
          end
          @query.update_predicates(params[:survey_query_predicates])
        else # clear out the answers
          @query.survey_query_predicates.delete_all
        end
      end
    rescue => ex
      render status: :bad_request, text: ex.message
    end
  end

  def destroy
    query = SurveyQuery.find(params[:id])
    
    # Test to make sure that the person requesting the delete owns the query
    if (query.user == @current_user && !support_user_signed_in?)
      query.destroy
      render status: :ok, text: {}.to_json
    else
      render status: :bad_request, text: 'Can not delete query owned by another user'
    end
  end
  
  #
  #
  #
  def copy
    
    begin
      SurveyQuery.transaction do
        raise "can not copy query as a support user" if support_user_signed_in?
        original = SurveyQuery.find(params[:id])
        
        @query = original.dup :include => :survey_query_predicates
        @query.name += ' (Copy)'
        @query.user = @current_user
        @query.shared = false
        
        @query.save!
      end
    rescue => ex
      render status: :bad_request, text: ex.message
    end

  end

end
