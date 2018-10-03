class Company < ApplicationRecord
  validates :name,
            presence: true,
            uniqueness: true
  has_many :employees, dependent: :destroy

  after_create   :expire_cache
  after_update   :expire_cache
  before_destroy :expire_cache

  def expire_cache
    ActionController::Base.new.expire_fragment('table_of_all_employees')
  end

  def to_s
    name
  end
end
