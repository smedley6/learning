class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :questions, dependent: :restrict_with_exception
  has_many :answers, dependent: :restrict_with_exception

  def author_of?(obj)
    obj.user_id == id
  end
end
