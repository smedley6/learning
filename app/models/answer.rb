class Answer < ApplicationRecord
  default_scope { order(accepted: :desc, created_at: :asc) }

  belongs_to :user
  belongs_to :question

  validates :body, presence: true

  def accept!
    transaction do
      question.answers.where(accepted: true).update(accepted: false)
      update(accepted: true)
    end
  end
end
