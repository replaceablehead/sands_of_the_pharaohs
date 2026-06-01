require 'chunky_png'

Dir.glob('assets/**/*.png').each do |file|
  image = ChunkyPNG::Image.from_file(file)
  if image.width == 64 && image.height == 64
    cropped = image.crop(16, 16, 32, 32)
    cropped.save(file)
    puts "Cropped #{file}"
  elsif image.width == 60 && image.height == 60
    cropped = image.crop(14, 14, 32, 32)
    cropped.save(file)
    puts "Cropped #{file}"
  elsif file.include?('cobra_boss') && image.width == 96 && image.height == 96
    cropped = image.crop(16, 16, 64, 64)
    cropped.save(file)
    puts "Cropped #{file}"
  end
end