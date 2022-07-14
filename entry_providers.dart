

import 'package:crud/models/entry.dart';
import 'package:crud/services/firestore_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

class EntryProvider with ChangeNotifier{
  final firestoreService = FirestoreService();
  DateTime _date;
  String _entry;
  String _entryId;
  var uuid=Uuid();

  DateTime get date=>_date;
  String get entry=> _entry;
  Stream<List<Entry>> get entries => firestoreService.getEntries();

  set ChangeDate(DateTime date){
    _date=date;
    notifyListeners();
  }
  set ChangeEntry(String entry){
    _entry= entry;
    notifyListeners();
  }

  loadAll(Entry entry){
    if(entry !=null){
      _date=DateTime.parse(entry.date);
      _entry =entry.entry;
      _entry=entry.entryId;
    }
    else{
      _date=DateTime.now();
      _entry=null;
      _entryId=null;
    }
  }
  saveEntry(){
    if(_entryId==null){
      //add
      var newEntry= Entry( date: _date.toIso8601String(),entry:_entry,entryId:uuid.v1());
      firestoreService.setEntry(newEntry);
    }
    else{
      var updatedEntry = Entry(date: _date.toIso8601String(),entry:_entry,entryId:_entryId);
      firestoreService.setEntry(updatedEntry);
      //edit
    }
  }
  removeEntry(String entryid){
    firestoreService.removeEntry(entryid);
  }
}