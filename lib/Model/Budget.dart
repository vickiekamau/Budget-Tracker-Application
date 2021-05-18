class Budget{
  int _id;
  int _amount;
  String _note;
  String _date;

  Budget(
      this._amount,
      this._note,
      this._date,
      );//unnamed constructor
  Budget.withId(this._id,this._amount,this._note,this._date);//named constructor called "with id"

  //getter methods
  int get id => _id;
  int get amount => _amount;
  String get note => _note;
  String get date => _date;

  set amount(int newAmount){
    this._amount = newAmount;
  }
  set note(String newNote){
    if(newNote.length<=255){
      this._note = newNote;
    }
  }
  set date(String newDate){
    this._date = newDate;
  }

  //convert a budget object into a map object
   Map<String, dynamic> toMap(){//we define dynamic so that both String and int values can work dynamically work for both int and string at runtime

    var map = Map<String,dynamic>();
    if(id != null){
      map['id'] = _id;
    }
    map['amount'] = _amount;
    map['note'] = _note;
    map['date'] = _date;

    return map;
   }
   //extract a Budget object from the map object
   Budget.fromMapObject(Map<String, dynamic>map){//Budget.fromMapObject is a named constructor that will take map as a parameter and simply create an instance of the Budget object

    this._id = map['id'];//extract id
     this._amount = map['amount'];//extract amount
     this._note = map['note'];//extract note
     this._date = map['date'];//extract date
   }
}