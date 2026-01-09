class Post < ApplicationRecord
  STATUSES = %w[draft published].freeze

  validates :title, :slug, :body_md, presence: true
  validates :status, presence: true, inclusion: { in: STATUSES }

  before_validation :apply_defaults
  before_validation :set_published_at, if: :publishing_without_timestamp?

  private

  def apply_defaults
    self.slug = title.to_s.parameterize if slug.blank?
    self.status = "draft" if status.blank?
  end

  def publishing_without_timestamp?
    status == "published" && published_at.blank?
  end

  def set_published_at
    self.published_at = Time.current
  end
end
