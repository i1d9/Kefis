part of 'package:client/helpers/imports.dart';



class UserForm extends StatelessWidget {
  final userInfo = Get.put(UserController());

  String firstName;
  String secondName;
  String phone;
  String email;
  String role;
  String password;
  String confirmPassword;
  String id;
  bool update;
  bool addingNewPartner;

  Map<String, dynamic> passedData;
  UserForm({
    Key? key,
    this.update = false,
    this.id = "",
    this.email = "",
    this.phone = "",
    this.firstName = "",
    this.secondName = "",
    this.role = "",
    this.password = "",
    this.confirmPassword = "",
    this.addingNewPartner = false,
    required this.passedData,

  }) : super(key: key);

  var userNameController = TextEditingController();
  var userPhoneController = TextEditingController();
  var userEmailController = TextEditingController();

  void sendData() {
    if (update) {
    } else {
      Map<String, dynamic> data = {
        "name": "API Test API",
        "phone": "254741287654",
        "location": "Mugumoinias",
        "contact_email": "user@retailer.com",
        "lat": "-1.268870",
        "lng": "36.785554",
        "type": "retailer",
        "user": {
          "first_name": "API",
          "second_name": "Test",
          "phone": "254741287654",
          "email": "api_test@gmail.com",
          "role": "retailer_admin",
          "password": "apitest@gmail.com",
          "confirm_password": "apitest@gmail.com"
        }
      };
      print(authenticationController.user["access_token"]);

      addUser(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        TextField(
          controller: userNameController,
          onChanged: (value) {
            userInfo.setFirstName = value;
          },
          decoration: const InputDecoration(
              border: OutlineInputBorder(), hintText: "First Name"),
        ),
        const SizedBox(
          height: 20,
        ),
        TextField(
          controller: userEmailController,
          onChanged: (value) {
            userInfo.setSecondName = value;
          },
          decoration: const InputDecoration(
              border: OutlineInputBorder(), hintText: "Second Name"),
        ),
        const SizedBox(
          height: 20,
        ),
        TextField(
          controller: userPhoneController,
          onChanged: (value) {
            userInfo.setPhone = value;
          },
          decoration: const InputDecoration(
              border: OutlineInputBorder(), hintText: "Phone"),
        ),
        const SizedBox(
          height: 20,
        ),
        const SizedBox(
          height: 20,
        ),
        const TextField(
          decoration:
              InputDecoration(border: OutlineInputBorder(), hintText: "Email"),
        ),
        GestureDetector(
          onTap: () {
            sendData();
          },
          child: Text(update ? "Update" : "Add"),
        )
      ]),
    ));
  }
}
