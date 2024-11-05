class EventModel {
  String? id;
  String title;
  String description;

  EventModel({this.id, required this.title, required this.description});

  // Converte um documento Firestore em um objeto EventModel
  factory EventModel.fromDocument(Map<String, dynamic> doc, String id) {
    return EventModel(
      id: id,
      title: doc['title'] ?? '',
      description: doc['description'] ?? '',
    );
  }

  // Converte um objeto EventModel em um mapa de dados para o Firestore
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
    };
  }
}
