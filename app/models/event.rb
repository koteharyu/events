class Event < ApplicationRecord
  validates :name, presence: true, length: { maximum: 50 }
  validates :plave, presence: true, length: { maximum: 100 }
  validates :content, presence: true, length: { maximum: 2000 }
  validates :start_at, presence: true
  validates :end_at, presence: true
  validate :start_at_should_be_before_end_at

  private

  def start_at_should_be_before_end_at
    return unless start_at && end_at

    if start_at > end_at
      # errors[:start_at] << "は終了時間よりも前にしてください"
      errors.add(:start_at, "は終了時間よりも前にしてください")
    end
  end
end
