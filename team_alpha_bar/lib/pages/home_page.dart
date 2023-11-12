import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import 'package:team_alpha_bar/components/event_view.dart';
import "package:team_alpha_bar/models/event_model.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;

  final eventList = Event.eventList();
  List<Event> foundEvent = [];
  final eventController = TextEditingController();

  // sign user out method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  void initState() {
    foundEvent = eventList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
            child: Column(
              children: [
                searchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          top: 50,
                          bottom: 20,
                        ),
                        child: const Text(
                          "Alle Events",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      for (Event event in foundEvent.reversed)
                        EventView(
                          event: event,
                          onEventChanged: handleEventChange,
                          onDeleteEvent: deleteEvent,
                        )
                    ],
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(
                      bottom: 20,
                      right: 20,
                      left: 20,
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 0.0),
                          blurRadius: 10.0,
                          spreadRadius: 0.0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: eventController,
                      decoration: const InputDecoration(
                        hintText: "Neues Event",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    bottom: 20,
                    right: 20,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      addEvent(eventController.text);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      minimumSize: const Size(56, 56),
                      elevation: 10,
                    ),
                    child: const Text(
                      "+",
                      style: TextStyle(
                        fontSize: 40,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      title: const Row(
        children: [
          Icon(
            Icons.menu,
            color: Colors.black,
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: signUserOut,
          icon: const Icon(
            Icons.logout,
            color: Colors.black,
          ),
        ),
      ],
      backgroundColor: Colors.grey[100],
    );
  }

  void handleEventChange(Event event) {
    setState(() {
      event.willJoin = !event.willJoin;
    });
  }

  void deleteEvent(String id) {
    setState(() {
      eventList.removeWhere(
        (element) => element.id == id,
      );
    });
  }

  void addEvent(String eventTitle) {
    setState(() {
      eventList.add(
        Event(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          title: eventTitle,
        ),
      );
    });
    eventController.clear();
  }

  void runFilter(String enteredKeyword) {
    List<Event> results = [];
    if (enteredKeyword.isEmpty) {
      results = eventList;
    } else {
      results = eventList
          .where(
            (element) => element.title!.toLowerCase().contains(
                  enteredKeyword.toLowerCase(),
                ),
          )
          .toList();
    }

    setState(() {
      foundEvent = results;
    });
  }

  Widget searchBox() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) => runFilter(value),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.black,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20,
            minWidth: 50,
          ),
          border: InputBorder.none,
          hintText: "Suchen",
          hintStyle: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
