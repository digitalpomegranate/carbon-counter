import 'dart:async';

import 'package:carbon_counter/base/base.dart';
import 'package:carbon_counter/models/category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/subjects.dart';

/// Contains actions specific for `Categories`.
/// `Categories` class is created and used in `AppModel` object.
/// Actions provided by this class should not be called directly from
///  UI layer and should be called only from Main Management class - app_model.dart.
class Categories {
  // Categories stream.
  final BehaviorSubject<List<Category>> categoriesStream =
      BehaviorSubject<List<Category>>();

  ///
  /// [getCategories] function should get all pollution sources
  /// in Firebase `categories` collection.
  ///
  /// Function should update `categoriesStream` stream and
  /// return `List` of  `Category`.
  ///
  Future<List<Category>> getCategories() async {
    // Categories list.
    List<Category> _categories = [];

    // Get categories.
    QuerySnapshot query =
        await Firestore.instance.collection(CATEGORIES_TABLE).getDocuments();

    for (DocumentSnapshot doc in query.documents) {
      _categories.add(
        Category.fromMap(doc.data..addAll({'id': doc.documentID})),
      );
    }

    /// Update `categoriesStream` stream.
    categoriesStream.sink.add(_categories);

    return _categories;
  }
}
