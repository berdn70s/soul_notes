import 'package:flutter/material.dart';
import 'package:soul_notes/models/Notes.dart';
import 'package:soul_notes/models/Notes.dart';
class NotesPage extends StatefulWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  // Controllers to manage note input fields
  final TextEditingController _partnerANoteController = TextEditingController();
  final TextEditingController _partnerBNoteController = TextEditingController();

  // Lists to store saved notes for each partner
  List<Notes> _partnerANotes = [];
  List<Notes> _partnerBNotes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Our Shared Notes'),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.purple],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Partner A's Notes Section
              Expanded(
                child: Container(
                  decoration:  BoxDecoration(
                    border: Border.all(color: Colors.pink, width: 2.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          'My Notes to You',
                          style: const TextStyle(
                            color: Colors.pink,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextField(
                            controller: _partnerANoteController,
                            maxLines: 10,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Write your heartfelt messages here...',
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_partnerANoteController.text.isNotEmpty) {
                            Notes newNote = Notes('Berdan', _partnerANoteController.text);
                            setState(() {
                              _partnerANotes.add(newNote);
                              _partnerANoteController.clear();
                            });
                          }
                        },
                        child: const Text('Add Note'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.pink,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20.0),

              // Partner B's Notes Section
              Expanded(
                child: Container(
                  decoration:  BoxDecoration(
                    border: Border.all(color: Colors.blue, width: 2.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          'My Notes to You',
                          style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextField(
                            controller: _partnerBNoteController,
                            maxLines: 10,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Write your romantic gestures here...',
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_partnerBNoteController.text.isNotEmpty) {
                            Notes newNote = Notes('Buket', _partnerBNoteController.text );
                            setState(() {
                              _partnerBNotes.add(newNote);
                              _partnerBNoteController.clear();
                            });
                          }
                        },
                        child: const Text('Add Note'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}