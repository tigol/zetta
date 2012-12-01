class TotsController < ApplicationController
  before_filter :get_topic
  
  respond_to :json
  respond_to :atom, :only => :index

  def index
    @tots = @topic.tots
    respond_with @tots
  end

  def show
    @tot = @topic.tot(params[:id])
    respond_with @tot
  end

  def create
    @tot = @topic.new_tot(params[:tot])
    @tot.save!
    respond_with @tot
  end

  def destroy
    @tot = @topic.tot(params[:id])
    tot.destroy
    head :ok
  end

  private
  def get_topic
    @topic = Topic.find(params[:topic_id])
  end
end
