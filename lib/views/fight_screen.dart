import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/fights.dart';
import 'notes.dart';

class FightScreen extends StatefulWidget {
  const FightScreen({Key? key}) : super(key: key);

  @override
  _FightScreenState createState() => _FightScreenState();
}

class _FightScreenState extends State<FightScreen> {
  var isSolved = Bool;
  final TextEditingController _textController = TextEditingController();
  List<Fight> fights = [
    Fight(name: 'Fight 1', date: '12.12.23', description: 'Description 1'),
    Fight(name: 'Fight 2', date: '12.12.23', description: 'Description 2'),
  ];

  void showDescriptionDialog(String description) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(backgroundColor:  Colors.white54,
          title:  Text(''),
          content: Text(description,),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
// DESCRIPTION KISMI COULDUYSE KALP SEKLINDE COZULMEDIYSE YARRRAK SEKLINDE
  void _showEditFightDialog(BuildContext context, Fight fight) {
    final _dateController = TextEditingController(text: fight.date);
    final _titleController = TextEditingController(text: fight.name);
    final _detailsController = TextEditingController(text: fight.description);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Fight'),
          content: Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [IconButton(onPressed: (){
                Navigator.of(context).push(PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) => NotesPage()));
              }, icon: Icon(Icons.data_saver_off)),
                TextFormField(
                  controller: _dateController,
                  decoration: const InputDecoration(labelText: 'Date'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a date.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _detailsController,
                  decoration: const InputDecoration(labelText: 'Details'),
                  minLines: 3,
                  maxLines: 5,
                ),
              ],
            ),
          ),
          actions: [ElevatedButton(onPressed: (){
            setState(() {
              fights.remove(fight);
              Navigator.pop(context);
            });
          }, child: const Text("Delete"),
          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red))),
            SizedBox(width: 30,),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final updatedFight = Fight(
                  date: _dateController.text,
                  name: _titleController.text,
                  description: _detailsController.text,
                );
                setState(() {
                  if (fight.name.isNotEmpty) {
                    fights[fights.indexOf(fight)] = updatedFight;
                  } else {
                    fights.add(updatedFight);
                  }
                });
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white54, Colors.purple],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,

        body: ListView.builder(
          itemCount: fights.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(fights[index].name),
              subtitle: Text(fights[index].date),
              onTap: () => showDescriptionDialog(fights[index].description),
              onLongPress: () {
                _showEditFightDialog(context, fights[index]);
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black45,
          onPressed: () {
            _showEditFightDialog(context, Fight(name: '', date: '', description: ''));
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}