import 'home_contract.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';

class HomePagePresenter implements HomePresenterContract {
  HomeViewContract view;
  DatabaseReference _databaseRef;
  StreamSubscription<Event> _counterSubscription;
  DatabaseError _error;

  int counter = 0;
  int counterMax;

  HomePagePresenter({this.counterMax}) {
    _prepareFirebaseConnection();
  }

  void _prepareFirebaseConnection() {
    _databaseRef = FirebaseDatabase.instance.reference().child('counter');
    _databaseRef.keepSynced(true);

    _counterSubscription = _databaseRef.onValue.listen((Event event) {
      print("Got value from database: ${event.snapshot.value}");
      _error = null;
      counter = event.snapshot.value ?? 0;
      view.updateCounterValue(counter);
    }, onError: (Object o) {

    });
  }

  @override
  void subscribe(HomeViewContract view) {
    this.view = view;
  }

  @override
  void decrementButtonClicked() {
    _decrementCounter();
  }

  @override
  void incrementButtonClicked() {
    _incrementCounter();
  }

  void _incrementCounter() {
    if (counter < counterMax) {
      _databaseRef.set(counter + 1);
    }
  }

  void _decrementCounter() {
    if (counter > 0) {
      _databaseRef.set(counter - 1);
    }
  }

  @override
  void unsubscribe() {
    _counterSubscription.cancel();
  }
}
