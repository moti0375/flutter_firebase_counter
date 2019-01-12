class HomePresenterContract{
  void subscribe(HomeViewContract view){}
  void unsubscribe(){}
  void incrementButtonClicked(){}
  void decrementButtonClicked(){}
}

class HomeViewContract{
  void updateCounterValue(int value){}
}