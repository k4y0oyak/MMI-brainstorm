class PublicationsController < ApplicationController
  before_action :set_publication, only: %i[ show edit update destroy ]

  # GET /publications or /publications.json
  def index
    @publications = Publication.all
    # @publication = Publication.all.order("created_at DESC")
  end

  # GET /publications/1 or /publications/1.json
  def show

  end

  # GET /publications/new
  def new
    if user_signed_in?
      @publication = current_user.publications.build  
    else
      redirect_to new_user_session_path
    end
    # Publication.new
  end

  # GET /publications/1/edit
  def edit
  end

  # POST /publications or /publications.json
  def create
    if user_signed_in?
      @publication = current_user.publications.build(publication_params)
    # @publication = Publication.new(publication_params)

    respond_to do |format|
      if @publication.save
        format.html { redirect_to @publication, notice: "Publication was successfully created." }
        format.json { render :show, status: :created, location: @publication }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @publication.errors, status: :unprocessable_entity }
      end
    end
  end
  end

  # PATCH/PUT /publications/1 or /publications/1.json
  def update
    respond_to do |format|
      if @publication.update(publication_params)
        format.html { redirect_to @publication, notice: "Publication was successfully updated." }
        format.json { render :show, status: :ok, location: @publication }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @publication.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /publications/1 or /publications/1.json
  def destroy
    @publication.destroy
    respond_to do |format|
      format.html { redirect_to publications_url, notice: "Publication was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_publication
      @publication = Publication.find(params[:id])
    end

    def find_pin
      @publication = Publication.find(params[:id])
     end

    # Only allow a list of trusted parameters through.
    def publication_params
      params.require(:publication).permit(:title, :description, :image)
    end
end
