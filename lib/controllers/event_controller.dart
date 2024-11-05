import '../models/event_model.dart';
import '../services/firestore_service.dart';

class EventController {
  final FirestoreService _firestoreService = FirestoreService();

  Future<void> addEvent(String title, String description) async {
    EventModel event = EventModel(title: title, description: description);
    await _firestoreService.addEvent(event);
  }

  Stream<List<EventModel>> getEvents() {
    return _firestoreService.getEvents();
  }

  Future<void> updateEvent(String docID, String title, String description) async {
    EventModel event = EventModel(id: docID, title: title, description: description);
    await _firestoreService.updateEvent(docID, event);
  }

  Future<void> deleteEvent(String docID) async {
    await _firestoreService.deleteEvent(docID);
  }
}
