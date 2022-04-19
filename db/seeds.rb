label = ["仕事", "資格", "勉強", "課題", "趣味"]
label.each do |i|
  Label.create!(genre: i)
end

task_title = ["issue", "problem", "test", "exam"]
label_ids = Label.pluck(:id)
count = label_ids.count

5.times do |n|
  name = Faker::Name.name
  email = Faker::Internet.email
  password = "password"
  user = User.create!(
    name: name,
    email: email,
    password: password,
  )

  rand(2..4).times do
    title = task_title.sample
    task = Task.create!(
      title: "#{title}_#{rand(0..10)}",
      overview: "#{title}_overview",
      status: rand(0..2),
      user_id: user.id,
    )

    start_on = Faker::Time.between(from: Date.today, to: Date.today + 10.days)
    end_on = Faker::Time.between(from: start_on + 2.days, to: start_on + 10.days)
    Event.create!(
      start_time_on: start_on,
      end_time_on: end_on,
      task_id: task.id,
    )

    task_label = label_ids.sample(rand(0..count))
    task_label.each do |label_id|
      Labeling.create!(
        task_id: task.id,
        label_id: label_id,
      )
    end

    rand(2..5).times do |j|
      task_item = TaskItem.create!(
        item: "item#{j + 1}",
        level: rand(1..9),
        task_id: task.id,
      )

      Memo.create!(
        content: "#{task_item.item}memo",
        task_item_id: task_item.id,
      )
    end
  end
end