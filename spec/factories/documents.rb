FactoryBot.define do
    factory :document do
    association :user

    trait :with_image do
      after :build do |document|
        file_name = 'image.png'
        file_path = Rails.root.join('spec', 'support', 'fixtures', file_name)
        document.doc.attach(io: File.open(file_path), filename: file_name, content_type: 'image/png')
      end
    end

    trait :with_video do
      after :build do |document|
        file_name = 'video.mp4'
        file_path = Rails.root.join('spec', 'support', 'fixtures', file_name)
        document.doc.attach(io: File.open(file_path), filename: file_name, content_type: 'video/mp4')
      end
    end

    trait :with_pdf do
      after :build do |document|
        file_name = 'pdf.pdf'
        file_path = Rails.root.join('spec', 'support', 'fixtures', file_name)
        document.doc.attach(io: File.open(file_path), filename: file_name, content_type: 'application/pdf')
      end
    end

    trait :with_csv do
      after :build do |document|
        file_name = 'import_csv.csv'
        file_path = Rails.root.join('spec', 'support', 'fixtures', file_name)
        document.doc.attach(io: File.open(file_path), filename: file_name, content_type: 'text/csv')
      end
    end
  end
end
