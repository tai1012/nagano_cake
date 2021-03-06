class Address < ApplicationRecord
  belongs_to :customer, optional: true
  validates :address, presence: true
  validates :postal_code, presence: true, format: {with: /\A\d{7}\z/}
  # validates

  def full_address
    '〒' + postal_code + ' ' + address + ' ' + name
  end

  # validates :zip_code, presence: true, format: {with: /\A\d{7}\z/}   # 郵便番号（ハイフンなし7桁）
  # def destination
  #   zip_code + " " + address + " " + name
  # end
end
