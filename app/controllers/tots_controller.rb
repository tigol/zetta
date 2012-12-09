class TotsController < ApplicationController
  before_filter :get_topic
  
  respond_to :json
  respond_to :atom, :only => :index
  respond_to :xlsx, :only => :index

  def index
    @tots = @topic.tots
    # use respond_to temporarily due to axlsx_rails 0.1.3's default setting
    respond_to do |format|
      format.xlsx {
        response.headers['Content-Disposition'] = "attachment; filename=\"#{@topic.name}.xlsx\""
      }
      format.all {
        respond_with @tots
      }
    end    
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
