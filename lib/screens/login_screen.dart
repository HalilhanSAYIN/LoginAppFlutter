import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loginapp/functions/validators.dart';
import 'package:loginapp/providers/auth_provider.dart';
import 'package:loginapp/providers/screen_providers.dart';
import 'package:loginapp/screens/home_screen.dart';
import 'package:loginapp/screens/register_screen.dart';
import 'package:loginapp/widgets/apple_button.dart';
import 'package:loginapp/widgets/google_button.dart';


final TextEditingController loginEmailTec = TextEditingController();
final TextEditingController loginPasswordTec = TextEditingController();

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final loginAnimation = ref.watch(loginLoadingProvider);
    final isPasswordObscured = ref.watch(loginPasswordVisibilityProvider);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: (height) * 0.8,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 40.0, bottom: 40.0, left: 40, right: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  
                  const Text("Google yada Apple hesabınla giriş yapabilirsin",style: TextStyle(fontSize: 14),),
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
                            "Email",
                            style: TextStyle(fontSize: 24),
                          ),
                        ],
                      ),
                      TextFormField(
                        controller: loginEmailTec,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onChanged: (text) {
                          Future(() {
                            bool isValid = validateEmail(text);
                            ref.read(emailValidatorState.notifier).state =
                                isValid;
                          });
                        },
                        validator: (text) {
                          bool isValid =
                              ref.read(emailValidatorState.notifier).state;
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
                        obscureText: isPasswordObscured,
                        controller: loginPasswordTec,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onChanged: (text) {
                          Future(() {
                            bool isValid = validatePassword(text);
                            ref.read(passwordValidatorState.notifier).state =
                                isValid;
                          });
                        },
                        validator: (text) {
                          bool isValid =
                              ref.read(passwordValidatorState.notifier).state;
                          if (!isValid) {
                            return "Şifre Minimum 6 Karakterden Oluşmalıdır!";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              isPasswordObscured
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              ref
                                  .read(loginPasswordVisibilityProvider.notifier).state = !isPasswordObscured;
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
                        if (ref.watch(emailValidatorState) == false || ref.watch(passwordValidatorState) == false) {
                          ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                                    backgroundColor: Colors.white,
                                    content: Text(
                                      "Lütfen Tüm Bilgileri Kontrol Ediniz!",
                                      style: TextStyle(color: Colors.black54),
                                    )));
                        } else {
                          ref.read(loginLoadingProvider.notifier).state = true;
                        ref.read(authProvider.notifier).login(loginEmailTec.text, loginPasswordTec.text).then((value) {
                          if (value == true) {
                            loginEmailTec.text ="";
                            loginPasswordTec.text = ""; 
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const HomeScreen(),),(route) => false,);
                          } else {
                            showDialog(context: context, builder: (context) {
                              return AlertDialog(
                                title: const Text("Hata",style: TextStyle(color: Colors.black)),
                                content: const Text("Hatalı Email veya Şifre",style: TextStyle(color: Colors.black)),
                                actions: [TextButton(onPressed: () {
                                  Navigator.pop(context);
                                }, child: const Text("Tamam",style: TextStyle(color: Colors.black)))],
                              );
                            },);
                          }
                        });
                        }
                       
                      },
                      child: loginAnimation == false ? const Text(
                        "Giriş Yap",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ) : const CupertinoActivityIndicator()
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Hesabın Yok mu? "),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const RegisterScreen()));
                          },
                          child: const Text(
                            "Kayıt Ol",
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




