# frozen_string_literal: true

Dir.glob("#{__dir__}/*.rb").each do |file|
    puts "app init#{file}"
    require file
  end