import 'package:flutter_riverpod/flutter_riverpod.dart';

// Login Screen Providers
final StateProvider emailValidatorState = StateProvider((ref) => false);
final StateProvider passwordValidatorState = StateProvider((ref) => false);
final StateProvider loginLoadingProvider = StateProvider((ref) => false);
final loginPasswordVisibilityProvider = StateProvider<bool>((ref) => true);

//Register Screen Providers 
final StateProvider registermailValidatorState = StateProvider((ref) => false);
final StateProvider registerpasswordValidatorState = StateProvider((ref) => false);
final StateProvider registerLoadingProvider = StateProvider((ref) => false);
final registerPasswordVisibilityProvider = StateProvider<bool>((ref) => true);
