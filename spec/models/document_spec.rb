require 'rails_helper'

RSpec.describe Document, type: :model do
  it 'has a valid factory' do
    document = FactoryBot.build(:document)
    expect(document.valid?).to be_falsey
    document = FactoryBot.build(:document, :with_image)
    expect(document.valid?).to be_truthy
    expect(document.doc.attached?).to be_truthy
    document.save!
    expect(document.doc.attached?).to be_truthy
    document = FactoryBot.build(:document, :with_video)
    expect(document.valid?).to be_truthy
    expect(document.doc.attached?).to be_truthy
    document.save!
    expect(document.doc.attached?).to be_truthy
    document = FactoryBot.build(:document, :with_pdf)
    expect(document.valid?).to be_truthy
    document = FactoryBot.build(:document, :with_csv)
    expect(document.valid?).to be_truthy
  end

  it 'must have user' do
    document = FactoryBot.build(:document, user: nil)
    expect(document.valid?).to be_falsey
  end

  it 'must contain file' do
    document = FactoryBot.build(:document, doc: nil)
    expect(document.valid?).to be_falsey
  end
end
