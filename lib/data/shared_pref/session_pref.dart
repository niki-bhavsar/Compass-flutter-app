abstract interface class SessionPref {
  setLoggedIn(bool loggedIn);

  bool isLoggedIn();

  Future clear();
}
