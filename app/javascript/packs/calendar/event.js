import { Calendar, elementClosest } from '@fullcalendar/core';
import interactionPlugin from '@fullcalendar/interaction';
import monthGridPlugin from '@fullcalendar/daygrid'
import googleCalendarApi from '@fullcalendar/google-calendar'

document.addEventListener('DOMContentLoaded', function() {
  let calendarEl = document.getElementById('calendar');

  let calendar = new Calendar(calendarEl, {
      plugins: [ monthGridPlugin, interactionPlugin, googleCalendarApi ],
      googleCalendarApiKey: process.env.GOOGLECALENDARAPI,

      eventSources: {
        googleCalendarId: 'ja.japanese#holiday@group.v.calendar.google.com',
        classNames: 'holiday',
        display: 'list-item',
        color: "#ff0000",
      },
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
        let el = info.el;
        if(el.classList.contains('holiday')){
          info.jsEvent.preventDefault();
        }
      },
      eventClassNames: function(arg){
      }
  });
  calendar.render();
});