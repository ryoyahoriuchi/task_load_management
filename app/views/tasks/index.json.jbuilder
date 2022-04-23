json.array!(@events) do |event|
  json.id event.id
  json.title event.task.title
  json.start event.start_time_on
  json.end event.end_time_on

  case event.task.status
  when "not_started"
    json.color "#4060ff"
  when "underway"
    json.color "#ff0060"
  when "completed"
    json.color "#ffff80"
  end
end