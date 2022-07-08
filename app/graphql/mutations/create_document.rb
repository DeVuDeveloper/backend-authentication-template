module Mutations
  class CreateDocument < Mutations::BaseMutation
    description "Create a document"

    argument :doc, ApolloUploadServer::Upload, required: true, description: "The document to upload"

    field :document, Types::Objects::DocumentType, null: false
    field :code, Types::Enums::CodeEnum, null: false

    def resolve(doc:)
      authenticate_user
      # First you need to create blob file in case of active storage. https://stackoverflow.com/q/70550808/4011757
      attachment = ActiveStorage::Blob::create_and_upload!(io: doc, filename: doc.original_filename, content_type: doc.content_type)
      document = context[:current_user].documents.build(doc: attachment)
      if document.save
        {document: document, code: "SUCCESS"}
      else
        raise GraphQL::ExecutionError.new(document.errors.full_messages.join(", "), extensions: {code: "UNPROCESSABLE_ENTITY", errors: document.errors})
      end
    end
  end
end
