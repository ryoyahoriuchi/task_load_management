import { Calendar } from '@fullcalendar/core';
import interactionPlugin from '@fullcalendar/interaction';
import monthGridPlugin from '@fullcalendar/daygrid'
import googleCalendarApi from '@fullcalendar/google-calendar'

document.addEventListener('DOMContentLoaded', function() {
  let calendarEl = document.getElementById('calendar');

  let calendar = new Calendar(calendarEl, {
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
});