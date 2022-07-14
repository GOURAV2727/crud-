
import 'package:crud/models/entry.dart';
import 'package:crud/providers/entry_providers.dart';
import 'package:crud/screen/entryy.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Homescreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var entryProvider = Provider.of<EntryProvider>(context);
    return Scaffold(
    appBar: AppBar(
      title: Text("My Journal"),
    ),
      body: StreamBuilder<List<Entry>>(
        stream: entryProvider.entries,
        builder: (context, snapshot) {
          return ListView.builder(
              itemCount:snapshot.data.length,
              itemBuilder: (context,index){
                return ListTile(
                  trailing: Icon(Icons.edit,
                    color: Theme.of(context).accentColor,
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) =>EntryScreen(entry: snapshot.data[index],)));
                  },
                );
              }
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> EntryScreen()));
        },
      ),
    );
  }
}
