import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loginapp/functions/validators.dart';
import 'package:loginapp/providers/auth_provider.dart';
import 'package:loginapp/providers/screen_providers.dart';
import 'package:loginapp/screens/login_screen.dart';
import 'package:loginapp/widgets/apple_button.dart';
import 'package:loginapp/widgets/google_button.dart';



final TextEditingController registerNameTec = TextEditingController();
final TextEditingController registerEmailTec = TextEditingController();
final TextEditingController registerPasswordTec = TextEditingController();

class RegisterScreen extends ConsumerWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final isPasswordObscured = ref.watch(registerPasswordVisibilityProvider);
    final loginAnimation = ref.watch(registerLoadingProvider);

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Kaydol",
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: (height) * 0.9,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 40.0, bottom: 40.0, left: 40, right: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text("Google yada Apple hesabınla giriş yapabilirsin"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GoogleButton(height: height, width: width),
                      AppleButton(height: height, width: width)
                    ],
                  ),
                  Column(
                    children: [
                      const Row(
                        children: [
                          Text(
                            "Ad",
                            style: TextStyle(fontSize: 24),
                          ),
                        ],
                      ),
                      TextFormField(
                        controller: registerNameTec,
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 1),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Row(
                        children: [
                          Text(
                            "Email",
                            style: TextStyle(fontSize: 24),
                          ),
                        ],
                      ),
                      TextFormField(
                        controller: registerEmailTec,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onChanged: (text) {
                          Future(() {
                            bool isValid = validateEmail(text);
                            ref
                                .read(registermailValidatorState.notifier)
                                .state = isValid;
                          });
                        },
                        validator: (text) {
                          bool isValid = ref
                              .read(registermailValidatorState.notifier)
                              .state;
                          if (!isValid) {
                            return "Lütfen Geçerli Bir Email Adresi Giriniz";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 1),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Row(
                        children: [
                          Text(
                            "Şifre",
                            style: TextStyle(fontSize: 24),
                          ),
                        ],
                      ),
                      TextFormField(
                        controller: registerPasswordTec,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onChanged: (text) {
                          Future(() {
                            bool isValid = validatePassword(text);
                            ref
                                .read(registerpasswordValidatorState.notifier)
                                .state = isValid;
                          });
                        },
                        validator: (text) {
                          bool isValid = ref
                              .read(registerpasswordValidatorState.notifier)
                              .state;
                          if (!isValid) {
                            return "Şifre Minimum 6 Karakterden Oluşmalıdır!";
                          }
                          return null;
                        },
                        obscureText: isPasswordObscured,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              isPasswordObscured
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              ref
                                  .read(registerPasswordVisibilityProvider
                                      .notifier)
                                  .state = !isPasswordObscured;
                            },
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 1),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: height * 0.065,
                    width: width * 0.8,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromARGB(255, 212, 55, 107),
                          Color.fromARGB(255, 146, 49, 170),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          if (registerNameTec.text == "" ||
                              ref.watch(registermailValidatorState) == false ||
                              ref.watch(registerpasswordValidatorState) ==
                                  false) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                                    backgroundColor: Colors.white,
                                    content: Text(
                                      "Lütfen Tüm Bilgileri Kontrol Ediniz!",
                                      style: TextStyle(color: Colors.black54),
                                    )));
                          } else {
                            ref.read(registerLoadingProvider.notifier).state =
                                true;
                            ref
                                .read(authProvider.notifier)
                                .register(
                                    registerNameTec.text,
                                    registerEmailTec.text,
                                    registerPasswordTec.text)
                                .then((value) {
                              if (value == true) {
                                registerNameTec.text = "";
                                registerEmailTec.text = "";
                                registerPasswordTec.text = "";
                                showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text(
                                          "Başarıyla Kayıt Oldunuz!",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        content: const Text(
                                            "Email ve Şifrenizle Giriş Yapabilirsiniz",
                                            style:
                                                TextStyle(color: Colors.black)),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pushAndRemoveUntil(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          const LoginScreen(),
                                                    ),
                                                    (route) => false);
                                              },
                                              child: const Text(
                                                  "Giriş Sayfasına Dön",
                                                  style: TextStyle(
                                                      color: Colors.black)))
                                        ],
                                      );
                                    });
                              } else {
                                AlertDialog(
                                  title: const Text(
                                      "Kayıt Sırasında Bir Hata Oluştu",
                                      style: TextStyle(color: Colors.black)),
                                  content: const Text(
                                      "Lütfen Bilgilerinizi Kontrol Edip Tekrar Deneyiniz!",
                                      style: TextStyle(color: Colors.black)),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Tamam",
                                            style:
                                                TextStyle(color: Colors.black)))
                                  ],
                                );
                              }
                            });
                          }
                        },
                        child: loginAnimation == false
                            ? const Text(
                                "Kayıt Ol",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              )
                            : const CupertinoActivityIndicator()),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Hesabın Yok mu? "),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Giriş Yap",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
