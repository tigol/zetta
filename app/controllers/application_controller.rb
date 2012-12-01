class ApplicationController < ActionController::Base
  protect_from_forgery
  rescue_from Exception, :with => :error_handler

  protected
  def error_handler(exception)
    
    if exception
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
end
