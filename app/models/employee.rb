class Employee < ApplicationRecord
	  belongs_to :company, touch: true
	  validates :first_name,
	            presence: true
	  validates :last_name,
	            presence: true
	  validates :company,
	            presence: true

	  # after_create   :expire_cache
	  # after_update   :expire_cache
	  # before_destroy :expire_cache

	  def to_s
	    "#{first_name} #{last_name}"
	  end

	  def company_name
	  	Rails.cache.fetch([:company, company_id, :name], expires_in: 5.minutes) do
	  		company.name
	  	end
	  end


	  def expire_cache
	    # Rails.cache.delete([:company, company_id, :name])
	  end

end
