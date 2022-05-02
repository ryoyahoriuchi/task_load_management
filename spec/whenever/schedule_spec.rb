require 'rails_helper'

# describe "Schedule" do
#   it 'schedule_checkが毎日実行されるか' do
#     schedule = Whenever::Test::Schedule.new(file: 'config/schedule.rb')

#     assert_equal "Task.schedule_check", schedule.jobs[:runner].first[:task]
#     assert_equal "[1 day, {:at=>"8:00 am"}]", schedule.jobs[:runner].first[:every]
#   end
# end