enum ScreenState {
  idle,
  loading,
  error,
  empty;

  bool get isIdle => this == idle;
  bool get isLoading => this == loading;
  bool get isError => this == error;
  bool get isEmpty => this == empty;
}
