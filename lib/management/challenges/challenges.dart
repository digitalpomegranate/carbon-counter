import 'package:carbon_counter/base/base.dart';
import 'package:carbon_counter/models/challenge.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/subjects.dart';

class Challenges {
  final BehaviorSubject<List<Challenge>> challenges =
      BehaviorSubject<List<Challenge>>();

  void challengesClose() {
    challenges.close();
  }

  Future<List<Challenge>> getChallenges() async {
    List<Challenge> _challenges;

    QuerySnapshot query =
        await Firestore.instance.collection(CHALLENGES_TABLE).getDocuments();

    _challenges = query.documents
        .map((documentSnapshot) => Challenge.fromMap(documentSnapshot))
        .toList();

    challenges.sink.add(_challenges);

    return _challenges;
  }
}
