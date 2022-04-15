import { Calendar} from '@fullcalendar/core';
import interactionPlugin from '@fullcalendar/interaction';
import monthGridPlugin from '@fullcalendar/daygrid'
import googleCalendarApi from '@fullcalendar/google-calendar'

document.addEventListener('turbolinks:load', function() {
  var calendarEl = document.getElementById('calendar');

  var calendar = new Calendar(calendarEl, {
      plugins: [ monthGridPlugin, interactionPlugin, googleCalendarApi ],

      events: '/tasks.json',

      locale: 'ja',
      timeZone: 'Asia/Tokyo',
      firstDay: 1,
      headerToolbar: {
        start: '',
        center: 'title',
        end: 'today prev,next' 
      },
      expandRows: true,
      stickyHeaderDates: true,
      buttonText: {
         today: '今日'
      }, 
      allDayText: '終日',
      height: "auto",

      dateClick: function(info){
      },
      eventClick: function(info){
      },
      eventClassNames: function(arg){
      }

  });
  calendar.render();

  $(".error").click(function(){
    calendar.refetchEvents();
  });

});