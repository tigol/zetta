require 'mongoid/sessions'

module Mongoid
	module VariableSessions 
    extend ActiveSupport::Concern

    include Mongoid::Sessions

    def collection
      if opts = self.class.persistence_options
        coll = mongo_session.with(opts)[collection_name]
        clear_persistence_options
        coll
      else
        mongo_session[collection_name]
      end
    end

    def collection_name
      @collection_name
    end
	end
end
