json.array!(@events) do |event|
  json.id event.id
  json.title event.task.title
  json.start event.start_time_on
  json.end event.end_time_on
end
