class ContentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_content, only: [:show , :update, :edit, :destroy]
  
  def index 
    
    @contents = current_user.contents.with_rich_text_description_and_embeds
    tag_titles = params[:tags]
    
    if tag_titles.present?
      @contents = @contents.joins(:tags).where(tags: { title: tag_titles }).distinct 
    end

  end

  def new  
    @content = Content.new
  end

  def create
    @content = Content.create(content_params)
    @content.user = current_user
    if @content.save 
      associated_tags!
      redirect_to contents_path, notice: 'Content was successfully created!'
    else
      render :new
    end
  end

  def edit; end

  def update 
    if @content.update(content_params)
      associated_tags!
      redirect_to contents_path, notice: 'Content was successfully updated!'
    else
      render :edit 
    end
  end

  def show;  end

  def destroy 
    @content.destroy
    redirect_to contents_path, notice: 'Content was successfully detroyed!'
  end
  private 

  def content_params 
    params.require(:content).permit(:title, :description, :tags)
  end

  def tags_params 
    params.require(:content).permit(tags: [])[:tags].reject(&:blank?)
  end

  def associated_tags!
    tags = tags_params.map do |tag_title| 
      current_user.tags.where(title: tag_title).first_or_initialize
    end
    @content.tags = tags
  end
  def set_content 
    @content = Content.find(params[:id])
  end
end