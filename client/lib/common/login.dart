part of 'package:client/helpers/imports.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const TextField(
          decoration: InputDecoration(
              border: OutlineInputBorder(), hintText: "Email Address"),
        ),
        SizedBox(
          height: 20,
        ),
        const TextField(
          obscureText: true,
          decoration: InputDecoration(
              border: OutlineInputBorder(), hintText: "Password"),
        ),
        SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: () async {
            var lol = login("userone@gmail.com", "userone@gmail.com");
          },
          child: const Text("Login"),
        )
      ]),
    ));
  }
}
