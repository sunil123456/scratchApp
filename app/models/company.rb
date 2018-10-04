class Company < ApplicationRecord
  validates :name,
            presence: true,
            uniqueness: true
  has_many :employees, dependent: :destroy

  after_create   :expire_cache
  after_update   :expire_cache
  before_destroy :expire_cache

  def expire_cache
     Rails.cache.delete([:company, self.id, :name])
  end

  def to_s
    name
  end
end
