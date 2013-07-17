module Serializable
  extend ActiveSupport::Concern

  module ClassMethods
    def with_optimistic(options)
      begin
        o = self.where(options).first_or_create
        yield o
        o.save!
      rescue ActiveRecord::StaleObjectError => e
        retry
      end
    end

    def with(options)
      self.transaction do
        connection.execute "LOCK TABLE #{self.table_name} IN ACCESS EXCLUSIVE MODE"
        o = self.where(options).first_or_create
        yield o
        o.save!
      end
    end
  end
end