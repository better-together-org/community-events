class TagsController < PlannerController
  # GET /tags
  # GET /tags.xml
  def index
    # For each of the possible contexts get the tags...
    className = params[:class]
    
    if isok(className)
      # 1. Get the set of contexts
      contexts1 = getContexts(className).sort_by{|name| name.downcase }
      contexts2 = TagContext.all.collect{|v| v.name}
      contexts = contexts1.concat(contexts2).collect{|a| a.downcase }.uniq.sort_by{|name| name.downcase }.collect{|n| n.capitalize}
      # 2. For each context get the tags for this person and add them to the results
      @allTagCounts = Hash.new
      contexts.each do |context|
        tags = TagsService.getTagCounts(className, context)
        if tags != nil
          @allTagCounts[context] = tags
        end
      end
    end
  # rescue => ex
    # render status: :bad_request, text: ex.message
  end

  # GET /tags/1
  # GET /tags/1.xml
  #
  # For a given class, get the object instance with the id and then get it's set of tags
  #
  def show
    # For each of the possible contexts get the tags...
    @className = params[:class]
    @personId = params[:id]
    
    # taggings.tagger_id IS NULl .... need to deal with owner ????
    
    if isok(@className)
      obj = eval(@className).find(@personId)
      # 1. Get the set of contexts
      # contexts = TagContext.all
      contexts1 = getContexts(@className).sort_by{|name| name.downcase }
      contexts2 = TagContext.all.collect{|v| v.name}
      contexts = contexts1.concat(contexts2).collect{|a| a.downcase }.uniq.sort_by{|name| name.downcase }.collect{|n| n.capitalize}
      
      # 2. For each context get the tags for thie person and add them to the results
      @allTags = Hash.new
      contexts.each do |context|
        if getTagOwner
          tags = obj.owner_tag_list_on(getTagOwner, context)
        else  
          tags = obj.tag_list_on( context )
        end
          
        if tags != nil
          @allTags[context] = tags
        end
      end
    end
  rescue => ex
    render status: :bad_request, text: ex.message
  end

  #
  # Get a set of the instances with the given tag
  #
  def list
    # For each of the possible contexts get the tags...
    context = params[:context] # context
    className = params[:class] # class
    exclude = params[:exclude]
    @results = nil
    
    op = exclude ? :match_all : :any
    query = ''
    if context.class == HashWithIndifferentAccess
      context.each do |key, ctx|
        query += ".tagged_with('" + params[:tag][key] + "', :on => '" + ctx + "', '+op+' => true)"
      end
    end

    if isok(className)
      cl = eval(className) # get the instance of the class
      page = params[:page] ? params[:page].to_i : 1
      pagesize = params[:pagesize] ? params[:pagesize].to_i : 10

      # Allowed operations are any or match_all, if exclude has been passed then we assume an exact match...
      if query.empty?
        @results = Person.tagged_with(params[:tag], :on => context, op => true).by_last_name.paginate(:page => page, :per_page => pagesize)
      else
        @results = eval "Person" + query + ".by_last_name.paginate(:page => page, :per_page => pagesize)"
      end
    end
    
    # 3. Then pass this along to the view
    respond_to do |format|
      format.html { render :layout => 'content' } # list.html.erb
      format.xml  { render :xml => @results }
    end
  end
  
  def add
    context = params[:context] # context
    className = params[:class] # class
    
    if isok(className)
      obj = eval(className).find(params[:id]) # object find by id
      tagList = params[:tag].split(',') # allow the addition of multiple tags (comma seperated)
    
      tagList.each do |tag|
        if getTagOwner
          obj.owner_tag_list_on(getTagOwner, context).add(tag) # set the tag list on the respondent for the context
        else
          obj.tag_list_on(context).add(tag) # set the tag list on the respondent for the context
        end
      end
      obj.id_will_change!
      obj.save
    end
    
    render status: :ok, text: {}.to_json
  end

  def remove
    context = params[:context] # context
    className = params[:class] # class

    if isok(className)
      obj = eval(className).find(params[:id]) # object find by id
      tag = params[:tag]
      
      if getTagOwner
        obj.owner_tag_list_on(getTagOwner, context).delete(tag)
      else
        obj.tag_list_on(context).delete(tag)
      end
      obj.id_will_change!
      obj.save
    end

    render status: :ok, text: {}.to_json
  end

# Create the edit form , the result will be to add a new tag(s)
# http://localhost:3000/tags/1/edit?class=Person&context=scienceItems
  def edit
    @context = params[:context] # context
    @className = params[:class] if isok(params[:class])
    @id = params[:id]

    # Just pass on to the form that will allow us to 'edit' the tag list i.e. to add tags
    respond_to do |format|
      format.html {render :layout => 'content'} # new.html.erb
    end
  end

  private
  
  #
  # Make sure that the parameter is not trying to execute a system command
  #
  def isok(input)
    # make sure that the input does not contain system ''
    ! input.downcase.include? 'system'
  end
  
  #
  # For a given class get all the tag contexts that are being used
  #
  def getContexts(className)
    taggings = ActsAsTaggableOn::Tagging.where(["taggable_type like ?", className]).
                  distinct(:context)
                  
    contexts = Array.new

    # for each context get the set of tags (sorted), and add them to the collection for display on the page
    taggings.each do |tagging|
      contexts << tagging.context
    end
    
    return contexts
  end

  private
  
  def getTagOwner
    nil
  end
  
end
