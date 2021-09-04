class ContentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_content, only: [:show , :update, :edit, :destroy]
  def index 
    @contents = current_user.contents
  end

  def new  
    @content = Content.new
  end

  def create
    @content = current_user.contents.build(content_params)
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

  def show; end

  def destroy 
    @content.destroy
    redirect_to contents_path, notice: 'Content was successfully detroyed!'
  end
  private 

  def content_params 
    params.require(:content).permit(:title, :description)
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