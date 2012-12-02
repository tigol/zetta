class TopicsController < ApplicationController
  skip_before_filter :verify_authenticity_token, 
    :if => Proc.new { |c| c.request.format == 'application/json' }
  respond_to :json

  def index
    @topics = Topic.all
    respond_with @topics
  end

  def show
    @topic = Topic.find(params[:id])
    respond_with @topic
  end

  def create
    logger.debug "create a topic #{params}"
    @topic = Topic.new(params[:topic])
    @topic.save!
    respond_with @topic
  end

  def update
    @topic = Topic.find(params[:id])
    @topic.update_attributes!(params[:topic])
    respond_with @topic
  end

  def destroy
    logger.debug "destroy topic #{params[:id]}"
    topic = Topic.find(params[:id])
    topic.destroy
    head :ok
  end
end
