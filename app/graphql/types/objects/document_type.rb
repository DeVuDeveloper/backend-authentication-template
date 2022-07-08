module Types
  module Objects
    class DocumentType < Types::BaseObject
      field :id, Integer, null: false
      field :documentable_type, String, null: true
      field :documentable_id, Integer, null: true
      field :content_type, String, null: true
      field :url, String, null: false
      field :created_at, GraphQL::Types::ISO8601DateTime, null: false
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

      def url
        Rails.env.development? || Rails.env.test? ? Rails.application.routes.url_helpers.rails_blob_path(object.doc) : object.doc.service_url
      end

      def content_type
        object.doc.present? ? object.doc.blob.content_type : nil
      end
    end
  end
end
