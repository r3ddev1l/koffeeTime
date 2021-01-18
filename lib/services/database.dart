import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:koffee_time/models/koffee.dart';
import 'package:koffee_time/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  //collection reference
  final CollectionReference koffeeCollection =
      Firestore.instance.collection('koffee');

  Future updateUserData({String sugar, int strength, String name}) async {
    return await koffeeCollection
        .document(uid)
        .setData({'sugar': sugar, 'name': name, 'strength': strength});
  }

  //koffee from snapshot
  List<Koffee> _koffeeListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map(
      (doc) {
        return Koffee(
          name: doc.data['name'] ?? '',
          sugar: doc.data['sugar'] ?? '0',
          strenght: doc.data['strength'] ?? 0,
        );
      },
    ).toList();
  }

  // get koffee stream
  Stream<List<Koffee>> get koffee {
    return koffeeCollection.snapshots().map(_koffeeListFromSnapshot);
  }

  //user data from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        name: snapshot.data['name'],
        strength: snapshot.data['strength'],
        sugar: snapshot.data['sugar']);
  }

  //get user doc stream
  Stream<UserData> get userData {
    return koffeeCollection
        .document(uid)
        .snapshots()
        .map(_userDataFromSnapshot);
  }
}
