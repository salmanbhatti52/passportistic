// import 'package:flutter/material.dart';
// import 'package:flutter_termii/flutter_termii.dart';
// import 'package:http/http.dart' as http;

// class TestPackage extends StatefulWidget {
//   const TestPackage({Key? key}) : super(key: key);

//   @override
//   State<TestPackage> createState() => _TestPackageState();
// }

// class _TestPackageState extends State<TestPackage> {
//   final _formKey = GlobalKey<FormState>();
//   final _phonenumberController = TextEditingController();

//   // Authenticate requests with valid Base URL and API Key
//   final termii = Termii(
//     url: 'https://api.ng.termii.com',
//     apiKey: 'TLWvfkn3YQ8bIPCs3RUNSiiwH3J0pylEp32adswyj0ymF43g3GpEKx25P4Q9pB',
//     senderId: 'GFL',
//   );
//   bool isLoading = false;
//   sendFunction() async {
//     String apiUrl = "https://api.ng.termii.com/api/sms/otp/verify";
//     print("api: $apiUrl");

//     setState(() {
//       isLoading = true;
//     });
//     final response = await http.post(Uri.parse(apiUrl), headers: {
//       'Accept': 'application/json',
//     }, body: {
//       "api_key":
//           "TLWvfkn3YQ8bIPCs3RUNSiiwH3J0pylEp32adswyj0ymF43g3GpEKx25P4Q9pB",
//       "pin_id": "c8dcd048-5e7f-4347-8c89-4470c3af0b",
//       "pin": "195558",
//     });
//     final responseString = response.body;
//     print("responseForgetPasswordApi: $responseString");
//     print("status Code ForgetPassword: ${response.statusCode}");

//     if (response.statusCode == 200) {
//       print("in 200 ForgetPassword");
//       print("responseForgetPasswordApi: $responseString");

//       print("SuucessFull");

//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Form(
//           key: _formKey,
//           child: Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 TextFormField(
//                   controller: _phonenumberController,
//                   decoration: const InputDecoration(
//                     contentPadding: EdgeInsets.symmetric(
//                       vertical: 8.0,
//                       horizontal: 12.0,
//                     ),
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 SizedBox(
//                   width: double.infinity,
//                   height: 60,
//                   child: TextButton(
//                     onPressed: () async {
//                       await sendFunction();
//                     },
//                     style: TextButton.styleFrom(
//                       foregroundColor: Colors.white,
//                       backgroundColor: Colors.blue,
//                     ),
//                     child: const Text('Submit'),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   _submit() async {
//     // destination/PhoneNumber must be in the international format (Example: 23490126727).
//     final responseData = await termii.sendSms(
//       destination: _phonenumberController.text,
//       message: "This is working",
//     );

//     final bulkResponseData = await termii.sendBulkSms(
//       multipleDestinations: ["23490555546", "23423490126999", "23490555546"],
//       message: "This is working for multiple numbers",
//       // channel is the route through which the message is sent. It is either dnd, whatsapp, or generic (default)
//       channel: "whatsapp",
//     );

//     final tokenResponseData = await termii.sendToken(
//       destination: _phonenumberController.text,
//       pinAttempts: 2, // 2 times
//       // pinExpiryTime represents how long the PIN is valid before expiration. The time is in minutes. The minimum time value is 0 and the maximum time value is 60
//       pinExpiryTime: 2, // 2 minutes
//       pinLength: 6,
//       // Right before sending the message, PIN code placeholder will be replaced with generated PIN code.
//       pinPlaceholder: "123456",
//       messageText: "Your pin is 123456",
//       messageType: MessageType.numeric,
//       pinType: MessageType.numeric,
//     );

//     final inAppTokenResponseData = await termii.generateInAppToken(
//       destination: _phonenumberController.text, // Example: 2349012672789
//       pinAttempts: 6, // 6 times
//       pinExpiryTime: 5, // 5 minutes
//       pinLength: 3,
//       pinType: MessageType.numeric,
//     );

//     final verifyTokenResponseData = await termii.verifyToken(
//       pinId: "c8dcd048-5e7f-4347-8c89-4470c3af0b",
//       pin: "195558",
//     );

//     final searchResponseData = await termii.searchPhoneNumber(
//       phoneNumber: _phonenumberController.text,
//     );

//     print(responseData);
//     print(bulkResponseData);
//     print(tokenResponseData);
//     print(inAppTokenResponseData);
//     print(verifyTokenResponseData);
//     print(searchResponseData);
//   }
// }
