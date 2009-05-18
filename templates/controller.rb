class <%= controller_class_name %>Controller < ApplicationController
  # GET /<%= table_name %>
  # GET /<%= table_name %>.xml
  # GET /<%= table_name %>.json
  def index
    @<%= table_name %> = <%= class_name %>.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @<%= table_name %> }
      format.json { render :json => @<%= table_name %> }
    end
  end

  # GET /<%= table_name %>/1
  # GET /<%= table_name %>/1.xml
  # GET /<%= table_name %>/1.json
  def show
    @<%= file_name %> = <%= class_name %>.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @<%= file_name %> }
      format.json  { render :json => @<%= file_name %> }
    end
  end

  # GET /<%= table_name %>/new
  # GET /<%= table_name %>/new.xml
  # GET /<%= table_name %>/new.json
  def new
    @<%= file_name %> = <%= class_name %>.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @<%= file_name %> }
      format.json  { render :json => @<%= file_name %> }
    end
  end

  # GET /<%= table_name %>/1/edit
  def edit
    @<%= file_name %> = <%= class_name %>.find(params[:id])
  end

  # POST /<%= table_name %>
  # POST /<%= table_name %>.xml
  # POST /<%= table_name %>.json
  def create
    
    respond_to do |format|
      format.json { @<%= file_name %> = <%= class_name %>.new.from_json(request.body.read) } 
      format.any { @<%= file_name %> = <%= class_name %>.new(params[:<%= file_name %>]) }
    end

    respond_to do |format|
      if @<%= file_name %>.save
        flash[:notice] = '<%= class_name %> was successfully created.'
        format.html { redirect_to(@<%= file_name %>) }
        format.xml  { render :xml => @<%= file_name %>, :status => :created, :location => @<%= file_name %> }
        format.json  { render :json => @<%= file_name %>, :status => :created, :location => @<%= file_name %> }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @<%= file_name %>.errors, :status => :unprocessable_entity }
        format.json  { render :json => @<%= file_name %>.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /<%= table_name %>/1
  # PUT /<%= table_name %>/1.xml
  # PUT /<%= table_name %>/1.json
  def update
    @<%= file_name %> = <%= class_name %>.find(params[:id])

    respond_to do |format|
      # Respond to a 'json' request with the json-decoded hashmap of the body of the request.
      format.json { @updated_<%= file_name %> = ActiveSupport::JSON.decode(request.body.read) }
      # Respond to 'any' request with the hashmap built from params[:<%= file_name %>]
      format.any { @updated_<%= file_name %> = params[:<%= file_name %>] }
    end

    respond_to do |format|
      if @<%= file_name %>.update_attributes(@updated_<%= file_name %>)
        flash[:notice] = '<%= class_name %> was successfully updated.'
        format.html { redirect_to(@<%= file_name %>) }
        format.xml  { head :ok }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @<%= file_name %>.errors, :status => :unprocessable_entity }
        format.json  { render :json => @<%= file_name %>.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /<%= table_name %>/1
  # DELETE /<%= table_name %>/1.xml
  # DELETE /<%= table_name %>/1.json
  def destroy
    @<%= file_name %> = <%= class_name %>.find(params[:id])
    @<%= file_name %>.destroy

    respond_to do |format|
      format.html { redirect_to(<%= table_name %>_url) }
      format.xml  { head :ok }
      format.json { head :ok }
    end
  end

  # GET /<%= table_name %>/schema.json
  def schema
    schema = Array.new
    columns = Array.new
    <%= class_name %>.columns.each do |column|
      columns.push({"name" => column.name, "type" => column.type});
    end
    schema.push({<%= class_name %>.table_name => columns});

    respond_to do |format|
      format.any { render :json => schema }
    end
  end
end
