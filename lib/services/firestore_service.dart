import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/event_model.dart';

class FirestoreService {
  final CollectionReference events = FirebaseFirestore.instance.collection('events');

  // CREATE - Adiciona um novo evento
  Future<void> addEvent(EventModel event) {
    return events.add(event.toMap());
  }

  // READ - Retorna um stream de eventos
  Stream<List<EventModel>> getEvents() {
    //  return events.orderBy('timestamp', descending: true).snapshots().map(
    return events.snapshots().map(
          (snapshot) => snapshot.docs.map((doc) => EventModel.fromDocument(doc.data() as Map<String, dynamic>, doc.id)).toList(),
    );
  }

  // TODO - Outra maneira de ler os dados (return e map dinâmico diferente?)
  //   Stream<List<EventModel>> getEvents() {
  //     return events.snapshots().map(
  //        (snapshot) => snapshot.docs.map((doc) {
  //               return EventModel.fromDocument(doc.data(), doc.id);
  //         }
  //     ).toList());
  //   }

  // UPDATE - Atualiza um evento existente
  Future<void> updateEvent(String docID, EventModel event) {
    return events.doc(docID).update(event.toMap());
  }

  // DELETE - Exclui um evento existente
  Future<void> deleteEvent(String docID) {
    return events.doc(docID).delete();
  }
}
