require 'rails_helper'

module Mutations
  RSpec.describe CreateDocument, type: :request do
    describe '.resolve' do
      let(:session) { FactoryBot.create(:session) }
      it 'create a document for the user' do
        session.user.confirm
        headers = sign_in_test_headers session
        params = FactoryBot.attributes_for(:document, :with_image, user_id: session.user_id)
        query = <<-GRAPHQL
        mutation ($input: CreateDocumentInput!) {
          createDocument(input: $input) {
            document {
              id
              url
            }
          }
        }
        GRAPHQL
        variables = { input: { doc: ::ApolloUploadServer::Wrappers::UploadedFile.new(ActionDispatch::Http::UploadedFile.new(
                                                                                       filename: 'image.png', type: 'image/png',
                                                                                       tempfile: File.new('spec/support/fixtures/image.png')
                                                                                     )) } }
        response = ApiSchema.execute(query, variables:, context: { current_user: session.user })
        expect(response.to_h['data']['createDocument']['document']['url']).not_to be_nil
      end
    end
  end
end
