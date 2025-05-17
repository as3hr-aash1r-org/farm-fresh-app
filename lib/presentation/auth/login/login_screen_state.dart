class LoginScreenState {
  bool isLoading = false;

  LoginScreenState({
    this.isLoading = false,
  });

  factory LoginScreenState.empty() {
    return LoginScreenState();
  }

  LoginScreenState copyWith({
    bool? isLoading,
  }) {
    return LoginScreenState(
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
