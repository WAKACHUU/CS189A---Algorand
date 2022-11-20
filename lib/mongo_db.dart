import 'constant.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'dart:developer';


class MongoDataBase{
  static connect() async
  {
    var db=await Db.create(MONGO_URL);
    await db.open();
    inspect(db);
    var collection=db.collection(COLLECTION_NAME);
  }

}