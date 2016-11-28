class Task < ApplicationRecord
  belongs_to :user_created, class_name: 'User', foreign_key: 'user_created_id'
  belongs_to :user_attributed, class_name: 'User', foreign_key: 'user_attributed_id', required: false
  has_many :follow_ups
end