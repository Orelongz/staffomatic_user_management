class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true

  scope :active, -> { where(deleted_at: nil) }
  scope :deleted, -> { where.not(deleted_at: nil) }

  belongs_to :deleted_by, class_name: 'User', optional: true

  def soft_delete(deleted_by_id)
    return true if deleted_at.present?

    update(deleted_at: Time.current, deleted_by_id: deleted_by_id)
  end

  def recover
    update(deleted_at: nil, deleted_by_id: nil)
  end
end
