class Category < ActiveRecord::Base

  has_many :products

  before_destroy :check_empty, prepend: true

  private

  def check_empty
    if self.products.size != 0
      errors.add(:base, "Cannot destroy non empty store")
      return false;
    end
  end

end
