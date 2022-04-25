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
        // googleCalendarId: process.env.GOOGLECALENDARID,
        googleCalendarId: 'ja.japanese#holiday@group.v.calendar.google.com',
        className: 'holiday'
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
        if($('#a').children().hasClass('holiday')){
          info.jsEvent.preventDefault();
        }
      },
      eventClassNames: function(arg){
      }

  });
  calendar.render();

  // $(".error").click(function(){
  //   calendar.refetchEvents();
  // });

});