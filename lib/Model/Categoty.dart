class Category{
  int _id;
  String _catName;
  String _date;

  Category(
      this._catName,
      this._date,
      );//unnamed constructor
  Category.withId(this._id,this._catName,this._date);//named constructor called "with id"

  //getter methods
  int get id => _id;
  String get categoryName => _catName;
  String get date => _date;

  set categoryName(String newName){
      this._catName = newName;
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
    map['categoryName'] = _catName;
    map['date'] = _date;

    return map;
  }
  //extract a Budget object from the map object
  Category.fromMapObject(Map<String, dynamic>map){//Budget.fromMapObject is a named constructor that will take map as a parameter and simply create an instance of the Budget object

    this._id = map['id'];//extract id
    this._catName = map['categoryName'];//extract category name
    this._date = map['date'];//extract date
  }
}