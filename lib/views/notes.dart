import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/Notes.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final TextEditingController _newNoteController = TextEditingController();
  List<Note> _notes = [
    Note('Berdan', 'I love you more than words can say.'),
    Note('Buket', 'You are the sunshine of my life.'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title:  Text('Our Notes'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,

      ),
      body: Container(
        padding: const EdgeInsets.only(top: kToolbarHeight + 40),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.purple],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            // Table for displaying notes
            Expanded(
              child: SingleChildScrollView(
                child: DataTable(
                  columns: const [
                    DataColumn(
                      label: Text('Partner'),
                    ),
                    DataColumn(
                      label: Text('Note'),
                    ),
                  ],
                  rows: _notes.map((note) {
                    return DataRow(
                      cells: [
                        DataCell(
                          GestureDetector(
                            // Double tap detection
                            onDoubleTap: () {
                              setState(() {
                                // Remove the note from the list
                                _notes.remove(note);

                                // Trigger UI rebuild
                                setState(() {});
                              });
                            },
                            child: Container( // This is the extra argument (1)
                              width: 150, // Adjust width as needed
                              child: Column(
                                  children: [
                                    Text(
                                      '${note.partner}', // Limit substring to include only date
                                      style: TextStyle(
                                        fontSize: 17.0, // Partner name font size
                                        color: Colors.black, // Partner name color
                                      ),
                                      textAlign: TextAlign.start, // Align text to avoid overlapping partner name
                                      overflow: TextOverflow.ellipsis, // Handle potential overflow
                                    ),


                                    Text(
                                      DateTime.now().toString().substring(0, 10), // Extract only time
                                      style: TextStyle(
                                        fontSize: 13.0, // Smaller time font size
                                        color: Colors.black87,
                                      ),
                                      textAlign: TextAlign.end, // Align time to the right
                                    ),
                                  ]),
                            ),
                          ),
                        ),
                        DataCell(
                          GestureDetector(
                            onTap: () => _editNote(note),
                            child: Text(note.content),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),

            // Add New Note Section
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _newNoteController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: 'Write your new note here...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.black), // Change this to your desired color
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.black38), // Change this to your desired color
                      ),
                    ),
                  )
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_newNoteController.text.isNotEmpty) {
                      setState(() {
                        _notes.add(Note('Buket', _newNoteController.text));
                        _newNoteController.clear();

                        // Implicitly trigger rebuild by calling setState
                        setState(() {});
                      });
                    }
                  },
                  child: const Text('Add Note',style: TextStyle(color: Colors.white60)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black54,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _editNote(Note note) {
    // Create a TextEditingController for the TextField
    final TextEditingController _controller = TextEditingController(text: note.content);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Note'),
        content: TextField(
          controller: _controller, // Use the controller here
          maxLines: 3,
          decoration: const InputDecoration(
            hintText: 'Edit your note here...',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                // Update the note content with the text from the controller
                note.content = _controller.text;
                _controller.clear();

                // Call setState() to trigger UI rebuild
                setState(() {});
              });
              Navigator.pop(context);
            },
            child: const Text('Save'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
            ),
          ),
        ],
      ),
    );
  }
}
