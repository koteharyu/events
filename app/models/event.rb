class Event < ApplicationRecord
  attr_accessor :remove_image
  searchkick language: "japanese"
  before_save :remove_image_if_user_accept

  validates :name, presence: true, length: { maximum: 50 }
  validates :place, presence: true, length: { maximum: 100 }
  validates :content, presence: true, length: { maximum: 2000 }
  validates :start_at, presence: true
  validates :end_at, presence: true
  validates :image, content_type: [:png, :jpg, :jpeg], size: { less_than_or_equal_to: 10.megabytes },
                    dimension: { width: { max: 2000 }, height: { max: 2000 } }
  validate :start_at_should_be_before_end_at

  belongs_to :owner, class_name: 'User'
  has_one_attached :image, dependent: false
  has_many :tickets, dependent: :destroy

  scope :not_held_events, -> { where('start_at > ?', Time.zone.now).order(:start_at) }

  def created_by?(user)
    return false unless user
    owner_id == user.id
  end

  private

  def start_at_should_be_before_end_at
    return unless start_at && end_at

    if start_at > end_at
      errors[:start_at] << "は終了時間よりも前にしてください"
      # errors.add(:start_at, "は終了時間よりも前にしてください")
    end
  end

  def remove_image_if_user_accept
    self.image = nil if ActiveRecord::Type::Boolean.new.cast(remove_image)
  end

  def search_data
    {
      name: name,
      place: place,
      content: content,
      owner_name: owner&.name,
      start_at: start_at
    }
  end
end
