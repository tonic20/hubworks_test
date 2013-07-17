class Payment < ActiveRecord::Base
  include Serializable

  belongs_to :service

  validates :line_item_id, uniqueness: {scope: :service_id}
end