import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loginapp/functions/format_date.dart';
import 'package:loginapp/providers/auth_provider.dart';
import 'package:loginapp/providers/user_provider.dart';
import 'package:loginapp/screens/login_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Kullanıcı Profili",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: FutureBuilder(
        future: ref.read(userProvider.notifier).user(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SizedBox(
              height: height * 0.7,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24)),
                      child: const Icon(
                        Icons.person,
                        size: 150,
                      ),
                    ),
                    ListTile(
                        title: const Text(
                          "Email : ",
                          style: TextStyle(fontSize: 24, color: Colors.white),
                        ),
                        subtitle: Text(
                          snapshot.data?.email ?? "veri yok",
                          style: const TextStyle(
                              fontSize: 24, color: Colors.white),
                        )),
                    ListTile(
                        title: const Text(
                          "Oluşturulma Tarihi : ",
                          style: TextStyle(fontSize: 24, color: Colors.white),
                        ),
                        subtitle: Text(
                          formatDate(snapshot.data!.createdAt!),
                          style: const TextStyle(
                              fontSize: 24, color: Colors.white),
                        )),
                    GestureDetector(
                      onTap: () {
                        ref.read(authProvider.notifier).logout().then((value) {
                          if (value == true) {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ),
                                (route) => false);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                backgroundColor: Colors.white,
                                content: Text(
                                  "Bir Hata Oluştu",
                                  style: TextStyle(color: Colors.black54),
                                )));
                          }
                        });
                      },
                      child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.logout_outlined,
                              size: 32,
                              color: Colors.white,
                            ),
                            Text("Çıkış Yap",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white))
                          ]),
                    ),
                  ],
                ),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const CupertinoActivityIndicator();
          } else {
            return const Text(
                "Bir Hata Oluştu Lütfen Daha Sonra Tekrar Deneyiniz");
          }
        },
      ),
    );
  }
}
