import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/core/resources/dialog_utils.dart';
import 'package:evently_app/data/DM/category_DM.dart';
import 'package:evently_app/data/DM/event_DM.dart';
import 'package:evently_app/data/DM/user_DM.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseServices {
  static CollectionReference<EventDm> getEventsCollection() {
    FirebaseFirestore db = FirebaseFirestore.instance;

    CollectionReference<EventDm> eventsCollection = db
        .collection("events")
        .withConverter<EventDm>(
      fromFirestore: (snapshot, _) => EventDm.fromJson(snapshot.data()!),
      toFirestore: (event, _) => event.toJson(),
    );

    return eventsCollection;
  }

  static Future<void> addEventsToFireStore(EventDm event) {
    // FirebaseFirestore db = FirebaseFirestore.instance; // create  object from cloud_fireStore
    //
    // CollectionReference<Map<String, dynamic>> eventsCollection = db.collection("events");
    //
    // DocumentReference<Map<String, dynamic>> document = eventsCollection.doc();
    //
    // event.id = document.id; // we have the id of each event for editing
    // return document.set(
    //   event.toJson()
    // );

    CollectionReference<EventDm> eventsCollection = getEventsCollection();
    DocumentReference<EventDm> document = eventsCollection.doc();

    event.id = document.id;

    UserDm.currentUser!.eventsIds.add(event.id);
    return document.set(event);
  }

  static Future<List<EventDm>> getEventOneTimeRead(CategoryDM category) async {
    CollectionReference<EventDm> eventsCollection = getEventsCollection();

    QuerySnapshot<EventDm> querySnapshot =
    await eventsCollection
        .where(
      "categoryID",
      isEqualTo: category.id == "0" ? null : category.id,
    )
        .orderBy("dateTime")
        .get();

    List<QueryDocumentSnapshot<EventDm>> documentsSnapshot = querySnapshot.docs;

    List<EventDm> events =
    documentsSnapshot.map((docSnapshot) => docSnapshot.data()).toList();

    return events;
  }

  static Stream<List<EventDm>> getEventsRealtimeUpdates(
      CategoryDM category,) async* {
    CollectionReference<EventDm> eventsCollection = getEventsCollection();

    Stream<QuerySnapshot<EventDm>> snapshots =
    eventsCollection
        .where(
      "categoryID",
      isEqualTo: category.id == "0" ? null : category.id,
    )
        .orderBy("dateTime")
        .snapshots();

    Stream<List<EventDm>> eventsStream = snapshots.map(
          (querySnapshot) =>
          querySnapshot.docs
              .map((documentSnapshot) => documentSnapshot.data())
              .toList(),
    );

    yield* eventsStream;
  }

  static CollectionReference<UserDm> getUserCollection() {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference<UserDm> usersCollection = db
        .collection("users")
        .withConverter<UserDm>(
      fromFirestore:
          (snapshot, options) => UserDm.fromJson(snapshot.data()!),
      toFirestore: (value, options) => value.toJson(),
    );

    return usersCollection;
  }

  static Future<void> addUserToFireStore(UserDm user) {
    CollectionReference<UserDm> usersCollection = getUserCollection();

    DocumentReference<UserDm> document = usersCollection.doc(user.id);

    return document.set(user);
  }

  static Future<UserDm> getUserFromFireStore(String uid) async {
    CollectionReference<UserDm> usersCollection = getUserCollection();
    DocumentSnapshot<UserDm> userDocument =
    await usersCollection.doc(uid).get();

    UserDm user = userDocument.data() as UserDm;

    return user;
  }

  static Future<void> register({
    required String email,
    required String password,
    required String name,
  }) async {
    final UserCredential credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    UserDm user = UserDm(
      name: name,
      email: email,
      id: credential.user!.uid,
      favEventsIds: [],
    );
    await addUserToFireStore(user);
  }

  static Future<UserDm?> readUserFromFireStore(String userId) async {
    DocumentSnapshot<UserDm> querySnapshot = await getUserCollection().doc(
        userId).get();
    return querySnapshot.data();
  }

  static Future<void> login(String email, String password) async {
    UserCredential credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

    UserDm user = await getUserFromFireStore(credential.user!.uid);
    UserDm.currentUser = user;

    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // await prefs.setBool("isFirstTimeToLogin", false);
    print(user.id);
    print(user.name);
    print(user.email);
  }

  static Future<void> loginWithGoogle(BuildContext context) async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    if (googleUser == null) return;

    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    var credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    var userCredential = await FirebaseAuth.instance.signInWithCredential(
        credential);

    User? firebaseUser = userCredential.user;
    if (firebaseUser == null) {
      DialogUtils.hideDialog(context);
      DialogUtils.showMessageDialog(
          context, message: "Failed to login with google",
          posActionTitle: "try again");
      return;
    }

    UserDm? myUser = await readUserFromFireStore(firebaseUser.uid);
    if (myUser == null) {
      myUser = UserDm(name: firebaseUser.displayName ?? "",
          email: firebaseUser.email ?? "",
          id: firebaseUser.uid,
          favEventsIds: []);

      await addUserToFireStore(myUser);
    }

    UserDm.currentUser = await getUserFromFireStore(myUser.id);
    DialogUtils.hideDialog(context);
  }

  static Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }

  //events
  static void addEventToFavorite(String eventId) async {
    UserDm user = UserDm.currentUser!;
    user.favEventsIds.add(eventId);
    await updateUser(user);
  }

  static void removeEventFromFavorite(String eventId) async {
    UserDm user = UserDm.currentUser!;
    user.favEventsIds.remove(eventId);
    await updateUser(user);
  }

  static Future<void> updateUser(UserDm user) {
    CollectionReference<UserDm> usersCollection = getUserCollection();

    DocumentReference<UserDm> usersDocuments = usersCollection.doc(user.id);

    return usersDocuments.set(user);
  }

  static Future<List<EventDm>> getEvents() async {
    CollectionReference<EventDm> eventsCollection = getEventsCollection();

    QuerySnapshot<EventDm> querySnapshot = await eventsCollection.get();

    List<QueryDocumentSnapshot<EventDm>> documentsSnapshot = querySnapshot.docs;

    List<EventDm> events =
    documentsSnapshot.map((document) => document.data()).toList();

    return events;
  }

  static Future<void> updateEventData(EventDm event) async {
    CollectionReference<EventDm> eventCollection = getEventsCollection();
    DocumentReference<EventDm> doc = eventCollection.doc(event.id);
    await doc.update(event.toJson());
  }

  static Future<void> deleteEvent(String eventId) async {
    CollectionReference<EventDm> eventCollection = getEventsCollection();
    DocumentReference<EventDm> doc = eventCollection.doc(eventId);
    await doc.delete();
  }

  static Future<void> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.setLanguageCode('en');

      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      print('Password reset email sent');
    } on FirebaseAuthException catch (e) {
      print('Error: ${e.code} - ${e.message}');
    }
  }
}
