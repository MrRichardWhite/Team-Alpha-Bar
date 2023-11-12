import 'package:flutter/material.dart';
import 'package:team_alpha_bar/models/event_model.dart';

class EventView extends StatelessWidget {
  final Event event;
  final onEventChanged;
  final onDeleteEvent;

  const EventView({
    super.key,
    required this.event,
    required this.onEventChanged,
    required this.onDeleteEvent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          onEventChanged(event);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 5,
        ),
        tileColor: Colors.white,
        leading: Icon(
          event.willJoin ? Icons.check_box : Icons.check_box_outline_blank,
          color: Colors.blue,
        ),
        title: Text(
          event.title!,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        trailing: Container(
          padding: const EdgeInsets.all(0),
          margin: const EdgeInsets.symmetric(vertical: 12),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(5),
          ),
          child: IconButton(
            color: Colors.white,
            iconSize: 18,
            icon: const Icon(Icons.delete),
            onPressed: () {
              onDeleteEvent(event.id);
            },
          ),
        ),
      ),
    );
  }
}
