class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :orders, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_many :addresses, dependent: :destroy

  validates :last_name_kana, format: { with: /\A[ァ-ヶー－]+\z/ }   # 全角カタカナ
  validates :first_name_kana, format: { with: /\A[ァ-ヶー－]+\z/ }   # 全角カタカナ
  validates :postal_code, format: { with: /\A\d{7}\z/ }   # 郵便番号（ハイフンなし7桁）
  validates :telephone_number, format: { with: /\A\d{10,11}\z/ }  # 電話番号(ハイフンなし10桁or11桁)
  validates :email, format: { with: /\A\S+@\S+\.\S+\z/ }

  # enum is_active: { '有効': true, '退会': false }

  def active_for_authentication?
    super && self.is_active == true
  end

  def inactive_message
    !is_active ? super : :deleted_account
  end
end
