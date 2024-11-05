import 'package:flutter/material.dart';
import '../controllers/event_controller.dart';
import '../models/event_model.dart';

class EventFormPage extends StatefulWidget {
  final EventModel? event;

  const EventFormPage({super.key, this.event});

  @override
  _EventFormPageState createState() => _EventFormPageState();
}

class _EventFormPageState extends State<EventFormPage> {
  final EventController _eventController = EventController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.event != null) {
      _titleController.text = widget.event!.title;
      _descriptionController.text = widget.event!.description;
    }
  }

  void _saveEvent() {
    if (widget.event == null) {
      _eventController.addEvent(_titleController.text, _descriptionController.text);
    } else {
      _eventController.updateEvent(widget.event!.id!, _titleController.text, _descriptionController.text);
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.event == null ? "Add Event" : "Edit Event"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: "Title"),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: "Description"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveEvent,
              child: Text(widget.event == null ? "Add" : "Save"),
            ),
          ],
        ),
      ),
    );
  }
}
