import 'package:crud/models/entry.dart';
import 'package:crud/providers/entry_providers.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EntryScreen extends StatefulWidget {
  final Entry entry;
  EntryScreen({this.entry});

  @override
  _EntryScreenState createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  final entryController= TextEditingController();
  @override
  void dispose(){
    entryController.dispose();
    super.dispose();
  }
  void intiState(){
    final entryProvider=Provider.of<EntryProvider>(context,listen: false);
    if(widget.entry !=null){
      entryController.text=widget.entry.entry;
      entryProvider.loadAll(widget.entry);
    }
    else
      entryProvider.loadAll(null);
    super.initState();
  }
  Widget build(BuildContext context) {
    final entryProvider = Provider.of<EntryProvider>(context);
    return Scaffold(
      appBar: AppBar(
    /*title: Text(formatDate(entryProvider.date,[MM,' ',d,', ',yyyy])),actions: [
          IconButton(icon: Icon(Icons.calendar_today),
              onPressed: (){
            _pickDate(context).then((value){
              entryProvider.ChangeDate=value;
            });
              },
          ),

      ],*/
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: "daily entry",
                border: InputBorder.none,
              ),
              maxLines: 12,
              minLines: 10,
             onChanged: (String value)=>entryProvider.ChangeEntry=value,
              controller: entryController,
            ),

            RaisedButton(
              child: Text("save",style: TextStyle(color: Colors.green),),
                onPressed: (){
                entryProvider.saveEntry();
                Navigator.of(context).pop();
                },
            ),
           (widget.entry !=null)? RaisedButton(
              child: Text("delete",style: TextStyle(color: Colors.green),),
              onPressed: (){
                entryProvider.removeEntry(widget.entry.entryId);
                Navigator.of(context).pop();
              },
            ):Container(),

          ],
        ),
      ),
    );
  }
}
Future<DateTime>_pickDate(BuildContext context)async{
  final DateTime picked= await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2021), lastDate: DateTime(2050));
}