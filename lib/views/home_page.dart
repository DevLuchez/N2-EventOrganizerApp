import 'package:flutter/material.dart';
import 'package:n2_event_organizer_app/services/firestore_service.dart';
import '../controllers/event_controller.dart';
import '../models/event_model.dart';
import 'event_form_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final EventController _eventController = EventController();

  void _openEventForm([EventModel? event]) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EventFormPage(
          event: event,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Event Organizer App"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openEventForm(),
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<List<EventModel>>(
        stream: _eventController.getEvents(),
        builder: (context, snapshot) {
          print(snapshot.data);

          if (snapshot.hasData) {
            var eventsList = snapshot.data!;
            return ListView.builder(
              itemCount: eventsList.length,
              itemBuilder: (context, index) {
                var event = eventsList[index];
                return ListTile(
                  title: Text(event.title),
                  subtitle: Text(event.description),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _openEventForm(event),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _eventController.deleteEvent(event.id!),
                      ),
                    ],
                  ),
                );
              },
            );
          }

          if (snapshot.hasError) {
            print(snapshot.error);
            return const Center(child: Text("Erro ao carregar eventos"));

          }
          else {
            return const Center(child: Text("Nenhum evento encontrado."));
          }
        },
      ),
    );
  }
}
