import 'dart:async';

import 'package:carbon_counter/base/base.dart';
import 'package:carbon_counter/management/management.dart';
import 'package:carbon_counter/models/plan/plan.dart';
import 'package:carbon_counter/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/subjects.dart';

/// Contains actions specific for `Plans`.
/// `Plans` class is created and used in `AppModel` object.
/// Actions provided by this class should not be called directly from
///  UI layer and should be called only from Main Management class - app_model.dart.
class Plans {
  // Signed user stream.
  final BehaviorSubject<List<Plan>> planList = BehaviorSubject<List<Plan>>();

  set planDataSet(List<Plan> newData) {
    planList.sink.add(newData);
  }

  void closePlanList() {
    planList.close();
  }

  /// [getPlans] function should get all pollution plans
  /// in Firebase `plans` collection.
  ///
  /// Function should update `Plans` stream and
  /// return `List` of  `Plan`.
  ///
  Future<List<Plan>> getPlans() async {
    List<Plan> plansList = List<Plan>();

    User user = await AppModel().users.currentUser;
    String postId = user.id;
    DocumentSnapshot plansSnapshot = await Firestore.instance
        .collection(PLANS_TABLE)
        .document(postId.toString())
        .get();
    if (plansSnapshot.data != null) {
      List<dynamic> plansData = plansSnapshot.data['data'];

      plansData.forEach((element) {
        plansList.add(Plan.fromJson(element));
      });
    }
    planDataSet = plansList;
    return plansList;
  }

  /// creates a new plans document on firestore when the user is registered
  Future<void> createPlansDocument(String userId) async {
    final CollectionReference postsRef =
        Firestore.instance.collection(PLANS_TABLE);

    var postID = userId;

    Map<String, dynamic> postData = {"data": []};
    await postsRef.document(postID.toString()).setData(postData);
  }

  /// adds a new Item to the Plans List
  Future<void> add(Plan plan) async {
    final CollectionReference postsRef =
        Firestore.instance.collection(PLANS_TABLE);

    /// get the user id
    User user = await AppModel().users.currentUser;
    await postsRef.document(user.id).updateData({
      'data': FieldValue.arrayUnion([plan.toJson()])
    });
    getPlans();
  }

  Future<void> update(Plan plan) async {
    final CollectionReference postsRef =
        Firestore.instance.collection(PLANS_TABLE);

    /// get the user id
    User user = await AppModel().users.currentUser;
    // get the Plans data list
    List<Plan> _plansList = planList.value;
    int updatingItemIndex = _plansList.indexWhere((elem) {
      return elem.planId == plan.planId;
    });
    _plansList[updatingItemIndex] = plan;
    List<dynamic> plansData = List<dynamic>();
    _plansList.forEach((element) {
      plansData.add(element.toJson());
    });
    await postsRef.document(user.id).updateData({"data": plansData});
    planDataSet = _plansList;
  }

  Future<void> delete(Plan plan) async {
    final CollectionReference postsRef =
        Firestore.instance.collection(PLANS_TABLE);

    /// get the user id
    User user = await AppModel().users.currentUser;
    await postsRef.document(user.id).updateData({
      'data': FieldValue.arrayRemove([plan.toJson()])
    });
    getPlans();
  }
}
