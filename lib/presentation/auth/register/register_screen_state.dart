class RegisterScreenState {
  bool isLoading = false;

  RegisterScreenState({
    this.isLoading = false,
  });

  factory RegisterScreenState.empty() {
    return RegisterScreenState();
  }

  RegisterScreenState copyWith({
    bool? isLoading,
  }) {
    return RegisterScreenState(
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
