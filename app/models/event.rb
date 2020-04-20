class Event < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :subscribers, through: :subscriptions, source: :user
  has_many :photos, dependent: :destroy

  validates :user, presence: true
  validates :title, presence: true, length: {maximum: 255}
  validates :address, presence: true
  validates :datetime, presence: true
  validate :can_not_in_the_past

  scope :sorted, -> { order(datetime: :desc) }

  def visitors
    (subscribers + [user]).uniq
  end

  private

  def can_not_in_the_past
    if datetime < Time.now
      errors.add(:datetime, I18n.t('event.can_not_in_the_past'))
    end
  end
end
