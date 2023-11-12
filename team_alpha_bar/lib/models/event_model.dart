class Event {
  String? id;
  String? title;
  bool willJoin;

  Event({
    required this.id,
    required this.title,
    this.willJoin = false,
  });

  static List<Event> eventList() {
    return [
      Event(id: "0", title: "Open Gym"),
      Event(id: "1", title: "Show Training", willJoin: true),
      Event(id: "2", title: "Open Gym", willJoin: true),
    ];
  }
}
