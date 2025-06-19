class RegisterScreenState {
  final bool isLoading;
  final bool isResending;
  final int remainingTime;
  final bool canResendOtp;
  final String? error;

  const RegisterScreenState({
    required this.isLoading,
    required this.isResending,
    required this.remainingTime,
    required this.canResendOtp,
    this.error,
  });

  factory RegisterScreenState.empty() {
    return const RegisterScreenState(
      isLoading: false,
      isResending: false,
      remainingTime: 60,
      canResendOtp: false,
    );
  }

  RegisterScreenState copyWith({
    bool? isLoading,
    bool? isResending,
    int? remainingTime,
    bool? canResendOtp,
    String? error,
  }) {
    return RegisterScreenState(
      isLoading: isLoading ?? this.isLoading,
      isResending: isResending ?? this.isResending,
      remainingTime: remainingTime ?? this.remainingTime,
      canResendOtp: canResendOtp ?? this.canResendOtp,
      error: error ?? this.error,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is RegisterScreenState &&
        other.isLoading == isLoading &&
        other.isResending == isResending &&
        other.remainingTime == remainingTime &&
        other.canResendOtp == canResendOtp &&
        other.error == error;
  }

  @override
  int get hashCode {
    return isLoading.hashCode ^
        isResending.hashCode ^
        remainingTime.hashCode ^
        canResendOtp.hashCode ^
        error.hashCode;
  }
}
