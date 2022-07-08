class Document < ApplicationRecord
  ## RELATIONSHIPS
  has_one_attached :doc
  belongs_to :documentable, polymorphic: true, optional: true
  belongs_to :user, optional: true

  ## VALIDATIONS
  validate :doc_presence, on: :create

  def doc_presence
    pattern = %r{^(image|application|text)/(.)+$}
    unless doc.attached? && pattern.match?(doc.attachment.blob.content_type)
      errors.add(:doc, I18n.t('errors.models.document.file_presence'))
    end
  end
end
