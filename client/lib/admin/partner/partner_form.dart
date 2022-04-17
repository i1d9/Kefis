part of 'package:client/helpers/imports.dart';

class PartnerController extends GetxController {
  var partnerName = "".obs;
  var partnerEmail = "".obs;
  var partnerPhone = "".obs;
  var partnerLocation = "".obs;
  var partnerType = "".obs;
  var partnerLat = 0.0.obs;
  var partnerLng = 0.0.obs;

  set setType(String value) => partnerType.value = value;
  set setName(String value) => partnerName.value = value;
  set setEmail(String value) => partnerEmail.value = value;
  set setPhone(String value) => partnerPhone.value = value;
  set setLocation(String value) => partnerLocation.value = value;
  void setCoordinates(double lat, double lng) {
    partnerLat.value = lat;
    partnerLng.value = lng;
  }
}

class PartnerForm extends StatelessWidget {
  final parterInfo = Get.put(PartnerController());

  String location;
  bool update = false;
  String id;
  double lat;
  String email;
  String image;
  double lng;
  String name;
  String phone;
  String type;

  PartnerForm(
      {Key? key,
      this.update = false,
      this.id = "",
      this.email = "",
      this.lat = 0.0,
      this.lng = 0.0,
      this.name = "",
      this.phone = "",
      this.type = "",
      this.image = "",
      this.location = ""})
      : super(key: key);

  var partnerNameController = TextEditingController();
  var partnerPhoneController = TextEditingController();
  var partnerEmailController = TextEditingController();

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
      

      Get.bottomSheet(
        UserForm(passedData: data),
        barrierColor: Colors.red[50],
        isDismissible: true,
      );
      //addPartner(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        TextField(
          controller: partnerNameController,
          onChanged: (value) {
            parterInfo.setName = value;
          },
          decoration: const InputDecoration(
              border: OutlineInputBorder(), hintText: "Name"),
        ),
        const SizedBox(
          height: 20,
        ),
        TextField(
          controller: partnerEmailController,
          onChanged: (value) {
            parterInfo.setEmail = value;
          },
          decoration: const InputDecoration(
              border: OutlineInputBorder(), hintText: "Email"),
        ),
        const SizedBox(
          height: 20,
        ),
        TextField(
          controller: partnerPhoneController,
          onChanged: (value) {
            parterInfo.setPhone = value;
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
        ),
        Container(
          
          height: 250,
          
          child: MapForm())
      ]),
    ));
  }
}
