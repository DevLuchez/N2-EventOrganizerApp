import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:n2_event_organizer_app/services/firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController textController = TextEditingController();
  final FirestoreService firestoreService = FirestoreService();

  void openNoteBox(String? docID) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: TextField(
            controller: textController,
          ),
          actions: [
            ElevatedButton(
                onPressed: () {
                  if (docID == null) {
                    firestoreService.addNote(textController.text); // add a new note
                  }

                  else {
                    firestoreService.updateNote(docID, textController.text);
                  }

                  textController.clear(); // clear the text controller
                  Navigator.pop(context); // close the box
                },
                child: Text("Add"),
            )
          ],
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            "N2 - Event Organizer App"
        ),
      ),
      
      floatingActionButton: FloatingActionButton(
          onPressed: () => openNoteBox(null), // add a new note it's not working
        child: const Icon(Icons.add),
      ),
      
      body: StreamBuilder<QuerySnapshot>(
        stream: firestoreService.getNotesStream(),

        builder: (context, snapshot) {
          // if we have data, get all the docs
          if (snapshot.hasData) {
            List notesList = snapshot.data!.docs;

            // display as a list
            return ListView.builder(
              itemCount: notesList.length,
              itemBuilder: (context, index) {
                // get each individual doc
                DocumentSnapshot document = notesList[index];
                String docID = document.id;

                // get note from each doc
                Map<String, dynamic> data = document.data() as Map<String,dynamic>;
                String noteText = data['note'];

                // display as list tile
                return ListTile(
                  title: Text(noteText),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Update button
                      IconButton(
                          onPressed: () => openNoteBox(docID),
                          icon: const Icon(Icons.edit)
                      ),

                      // Delete button
                      IconButton(
                          onPressed: () => firestoreService.deleteNote(docID),
                          icon: const Icon(Icons.delete)
                      ),
                    ],
                  )
                );
              }
            );
          }

          // if there is no data return nothing
          else {
            return const Text("No notes...");
          }
        }
      )
    );
  }
}