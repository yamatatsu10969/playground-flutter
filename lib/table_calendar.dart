import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
          child: child!,
        );
      },
      home: const MyHomePage(title: 'Table Calendar'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: TableCalendar<_Event>(
        shouldFillViewport: true,
        focusedDay: DateTime.now(),
        firstDay: DateTime(2010),
        lastDay: DateTime(2030),
        startingDayOfWeek: StartingDayOfWeek.monday,
        holidayPredicate: (day) {
          return day.weekday == DateTime.sunday;
        },
        eventLoader: (day) {
          return [
            _WorkEvent(day, 'WorkWork'),
            _HobbyEvent(day, 'Hobby'),
            _WorkEvent(day, 'WorkWork'),
            _HobbyEvent(day, 'Hobby'),
            if (day.day.isEven) _HobbyEvent(day, 'Hobby'),
            // _HobbyEvent(day, 'Hobby'),
          ];
        },
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          titleTextFormatter: (date, dynamic locale) {
            return DateFormat('yyyy年M月').format(date);
          },
          leftChevronIcon: const Icon(
            Icons.chevron_left,
            color: Colors.white,
          ),
          rightChevronIcon: const Icon(
            Icons.chevron_right,
            color: Colors.white,
          ),
          decoration: const BoxDecoration(
            color: Colors.blue,
          ),
        ),
        calendarStyle: const CalendarStyle(
          cellMargin: EdgeInsets.zero,
          canMarkersOverflow: false,
          markerSize: 0.5,
          tableBorder: TableBorder(
            horizontalInside: BorderSide(color: Colors.grey, width: 0.5),
            verticalInside: BorderSide(color: Colors.grey, width: 0.5),
          ),
        ),
        // daysOfWeekStyle: DaysOfWeekStyle(),
        calendarBuilders: CalendarBuilders(
          todayBuilder: defaultCalendarBuilder,
          outsideBuilder: (context, day, focusedDay) => defaultCalendarBuilder(
            context,
            day,
            focusedDay,
            color: Colors.grey,
          ),
          defaultBuilder: defaultCalendarBuilder,
          holidayBuilder: holidayCalendarBuilder,
          markerBuilder: (context, day, events) {
            // Column だと canMarkersOverflow が効かずに overflow する
            return Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: events[index].backgroundColor,
                    ),
                    padding: const EdgeInsets.all(2),
                    margin: const EdgeInsets.all(2).copyWith(bottom: 0),
                    child: Text(
                      events[index].title,
                      style: const TextStyle(color: Colors.white),
                      maxLines: 1,
                    ),
                  );
                },
                itemCount: events.length,
                physics: const NeverScrollableScrollPhysics(),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget? defaultCalendarBuilder(
    BuildContext context,
    DateTime day,
    DateTime focusedDay, {
    Color? color,
  }) {
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.all(4),
      child: Text(
        day.day.toString(),
        style: TextStyle(
          color: color ?? Colors.black54,
        ),
      ),
    );
  }

  Widget? holidayCalendarBuilder(
    BuildContext context,
    DateTime day,
    DateTime focusedDay,
  ) {
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.all(4),
      color: Colors.red[100],
      child: Text(
        day.day.toString(),
        style: const TextStyle(
          color: Colors.red,
        ),
      ),
    );
  }
}

abstract class _Event {
  _Event(this.date, this.title, this.backgroundColor);

  final DateTime date;
  final String title;
  final Color backgroundColor;
}

class _WorkEvent implements _Event {
  _WorkEvent(this.date, this.title);

  @override
  final DateTime date;
  @override
  final String title;
  @override
  final Color backgroundColor = Colors.red;
}

class _HobbyEvent implements _Event {
  _HobbyEvent(this.date, this.title);

  @override
  final DateTime date;
  @override
  final String title;
  @override
  final Color backgroundColor = Colors.green;
}
