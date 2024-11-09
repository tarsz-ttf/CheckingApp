// cleaning_schedule.dart
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CleaningScheduleScreen extends StatefulWidget {
  @override
  _CleaningScheduleScreenState createState() => _CleaningScheduleScreenState();
}

class _CleaningScheduleScreenState extends State<CleaningScheduleScreen> {
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Takarítás Időpontfoglalás'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TableCalendar(
              firstDay: DateTime.now(),
              lastDay: DateTime.now().add(Duration(days: 30)),
              focusedDay: DateTime.now(),
              selectedDayPredicate: (day) => isSameDay(day, _selectedDate),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDate = selectedDay;
                });
              },
              calendarFormat: CalendarFormat.month,
              startingDayOfWeek: StartingDayOfWeek.monday,
              headerStyle: HeaderStyle(formatButtonVisible: false),
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _selectedDate != null
                  ? () {
                // Például: itt kezelheted a foglalást, vagy elmentheted az adatokat
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Időpont jóváhagyva: ${_selectedDate.toString()}'),
                  ),
                );
              }
                  : null, // a gomb csak akkor aktív, ha van kiválasztott dátum
              child: Text('Időpont Jóváhagyása'),
            ),
          ),
        ],
      ),
    );
  }
}
