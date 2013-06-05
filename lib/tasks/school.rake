namespace :school do
  desc "Import schools from CSV"
  task import: :environment do
    require "csv"

    puts "[ERROR] CSV source not provided, cannot run this task.\n" and return if ENV['csv_file'].blank? || ENV['csv_path'].blank?

    file_content = if ENV['csv_file']
      File.open(ENV['csv_file']).read
    elsif ENV['csv_path']
      Faraday.get(ENV['csv_path']).body
    end

    puts "[ERROR] CSV content is blank, cannot run this task.\n"  and return if file_content.blank?

    count = 0

    CSV.parse(file_content) do |row|
      name = row[1].squish.downcase.titleize
      lat = row[2]
      lon = row[3]
      address = row[4].squish.downcase.titleize
      city = row[5].squish.downcase.titleize
      state = row[6].squish
      zip = row[7].squish
      type = row[8].squish.downcase == 'public' ? :public : :other

      School.create!(name: name, city: city, address: address, state: state, zip: zip, type_enum: type, coordinates: [lon.to_f, lat.to_f], state_enum: 1)
      count += 1
      puts "Count so far: #{count}" if count > 0 && count % 3000 == 0
    end

    puts "Total imported: #{count}"
  end
end
