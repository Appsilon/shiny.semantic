var semanticDateRangeBinding = new Shiny.InputBinding();

function updateSingleCalendar(calendarElement, value) {
  if (value !== null) {
    calendarElement.calendar('set date', value)
  }
}

function retrieveRangeCalendars(el) {
  const calendars = $(el).find('.ss-input-date-range-item')

  return {
    start: calendars.eq(0),
    end: calendars.eq(1)
  }
}

function updateCalendarInterval(calendarElement, intervalType, value) {
  calendarElement.calendar(`set ${intervalType}Date`, value)
  calendarElement.attr(`data-${intervalType}-date`, value);
}

$.extend(semanticDateRangeBinding, {

  // This initialize input element. It extracts data-value attribute and use that as value.
  initialize: function(el) {
    const calendarRange = retrieveRangeCalendars(el);

    calendarRange.start.calendar({
      type: calendarRange.start.data('type'),
      endCalendar: calendarRange.end
    });

    calendarRange.end.calendar({
      type: calendarRange.end.data('type'),
      onChange: function(date, text, mode) {
        calendarRange.end.trigger('change.semanticDateRangeBinding');
      },
      startCalendar: calendarRange.start
    })
  },

  // This returns a jQuery object with the DOM element.
  find: function(scope) {
    return $(scope).find('.semantic-input-date-range');
  },

  // Return the date in an unambiguous format, yyyy-mm-dd (as opposed to a
  // format like mm/dd/yyyy)
  getValue: function(el) {
    const calendarRange = retrieveRangeCalendars(el);
    return [
      formatDate(calendarRange.start.calendar('get date')),
      formatDate(calendarRange.end.calendar('get date'))
    ];
  },

  setValue: function(el, value) {
    const calendarRange = retrieveRangeCalendars(el);

    updateSingleCalendar(calendarRange.start, value.start);
    updateSingleCalendar(calendarRange.end, value.end);
  },

  subscribe: function(el, callback) {
    $(el).on('change.semanticDateRangeBinding', function(event) {
      callback(true);
    });
  },

  unsubscribe: function(el) {
    $(el).off('.semanticDateRangeBinding');
  },

  getRatePolicy: function() {
    return {
      policy: 'debounce',
      delay: 250
    };
  },

  receiveMessage: function(el, data) {
    const calendarRange = retrieveRangeCalendars(el);
    if (data.hasOwnProperty('min')) {
      updateCalendarInterval(calendarRange.start, 'min', data.min)
      updateCalendarInterval(calendarRange.end, 'min', data.min)
    }

    if (data.hasOwnProperty('max')) {
      updateCalendarInterval(calendarRange.start, 'max', data.max)
      updateCalendarInterval(calendarRange.end, 'max', data.max)
    }

    this.setValue(el, {start: data.start_value, end: data.end_value})
    const values = this.getValue(el);
    calendarRange.start.attr('data-date', values[0]);
    calendarRange.end.attr('data-date', values[1]);

    $(el).trigger("change.semanticDateRangeBinding")
  }
});

Shiny.inputBindings.register(semanticDateRangeBinding, 'shiny.semanticDateRange');
