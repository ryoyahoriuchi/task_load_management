label = ["仕事", "資格", "勉強"]
label.each do |i|
  Label.create!(genre: i)
end