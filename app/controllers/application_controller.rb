class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from Exception, :with => :error_handler  
  rescue_from Mongoid::Errors::DocumentNotFound, :with => :not_found

  protected
  def not_found(exception)
    logger.error exception.message
      respond_to do |format|
        format.json  { 
          render :template => 'errors/error', 
            :handlers => [:jbuilder],
            :status => 404, 
            :locals => {:exception => exception}
        }
    end
  end

  def error_handler(exception)
    puts exception.class
    logger.error exception.message
    respond_to do |format|
      format.json  { 
        render :template => 'errors/error', 
          :handlers => [:jbuilder],
          :status => 500, 
          :locals => {:exception => exception}
      }
    end
  end
end
