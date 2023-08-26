import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:scanguard/auth/signUpNextPage.dart';
import 'package:scanguard/auth/signUpPage.dart';
import 'package:http/http.dart' as http;
import '../Home/mainScreenHome.dart';
import '../Models/currencyModel.dart';
import '../Models/getGenderList.dart';
import '../Models/signUpDetailsModels.dart';
// import 'package:country_picker/country_picker.dart';

class SignupDetails extends StatefulWidget {
  final String? userId;
  final String? email;

  const SignupDetails({super.key, this.userId, this.email});

  @override
  State<SignupDetails> createState() => _SignupDetailsState();
}

class _SignupDetailsState extends State<SignupDetails> {
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController middleName = TextEditingController();
  TextEditingController nationality = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController email = TextEditingController();
  SignUpDetailsModel signUpDetailsModel = SignUpDetailsModel();

  String? _selectedcurrency;
  String? _slectedGenderId;

  signUpUser() async {
    // try {

    String apiUrl = "$baseUrl/detailed_signup";
    print("api: $apiUrl");
    print("email: ${email.text}");

    setState(() {
      isLoading = true;
    });
    final response = await http.post(Uri.parse(apiUrl), headers: {
      'Accept': 'application/json',
    }, body: {
      "passport_holder_id": widget.userId,
      "first_name": firstname.text,
      "middle_name": middleName.text,
      "last_name": lastname.text,
      "nationality": _selectedCountry?.displayNameNoCountryCode.toString(),
      "gender_id": _slectedGenderId.toString(),
      "dob": dob.text,
      "number_of_pages": selectedPageText,
      "currency_id": _selectedcurrency,
      "phone_number": phone.text.toString(),
    });
    final responseString = response.body;
    print("responseSignInApi: $responseString");
    print("status Code Signup: ${response.statusCode}");

    if (response.statusCode == 200) {
      print("SuucessFull");
      print("in 200 signup");
      signUpDetailsModel = signUpDetailsModelFromJson(responseString);
      setState(() {
        isLoading = false;
      });
      print('signInModel status: ${signUpDetailsModel.status}');
    }
  }

  CurrencyModel currencyModel = CurrencyModel();

  getCurrency() async {
    // try {

    String apiUrl = "$baseUrl/get_currency_list";
    print("api: $apiUrl");

    setState(() {
      isLoading = true;
    });
    final response = await http.post(Uri.parse(apiUrl), headers: {
      'Accept': 'application/json',
    }, body: {
      "passport_holder_id": widget.userId,
    });
    final responseString = response.body;
    print("responsecurrencyModelApi: $responseString");
    print("status Code currencyModel : ${response.statusCode}");

    if (response.statusCode == 200) {
      print("SuucessFull");
      print("in 200 Currency list");
      currencyModel = currencyModelFromJson(responseString);
      setState(() {
        isLoading = false;
      });
      print('currecnyModel status: ${signUpDetailsModel.status}');
    }
  }

  GetGenderListModels getGenderListModels = GetGenderListModels();

  getGenderList() async {
    // try {
    String apiUrl = "$baseUrl/get_gender_list";
    print("api: $apiUrl");

    setState(() {
      isLoading = true;
    });
    final response = await http.post(Uri.parse(apiUrl), headers: {
      'Accept': 'application/json',
    }, body: {
      "passport_holder_id": widget.userId,
    });
    final responseString = response.body;
    print("getGenderListModels: $responseString");
    print("status Code getGenderListModels : ${response.statusCode}");

    if (response.statusCode == 200) {
      print("SuucessFull");
      print("in 200 getGenderListModels list");
      getGenderListModels = getGenderListModelsFromJson(responseString);
      setState(() {
        isLoading = false;
      });

      print('getGenderListModels status: ${getGenderListModels.status}');
    }
  }

  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final FocusNode _focusNode3 = FocusNode();
  final FocusNode _focusNode4 = FocusNode();
  final FocusNode _focusNode5 = FocusNode();
  final FocusNode _focusNode6 = FocusNode();
  final FocusNode _focusNode7 = FocusNode();
  final FocusNode _focusNode8 = FocusNode();
  final FocusNode _focusNode9 = FocusNode();

  @override
  void initState() {
    super.initState();
    getGenderList();
    getCurrency();
    _focusNode1.addListener(_onFocusChange);
    _focusNode2.addListener(_onFocusChange);
    _focusNode3.addListener(_onFocusChange);
    _focusNode4.addListener(_onFocusChange);
    _focusNode5.addListener(_onFocusChange);
    _focusNode6.addListener(_onFocusChange);
    _focusNode7.addListener(_onFocusChange);
    _focusNode8.addListener(_onFocusChange);
    _focusNode9.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode1.removeListener(_onFocusChange);
    _focusNode2.removeListener(_onFocusChange);
    _focusNode3.removeListener(_onFocusChange);
    _focusNode4.removeListener(_onFocusChange);
    _focusNode5.removeListener(_onFocusChange);
    _focusNode6.removeListener(_onFocusChange);
    _focusNode7.removeListener(_onFocusChange);
    _focusNode8.removeListener(_onFocusChange);
    _focusNode9.removeListener(_onFocusChange);

    super.dispose();
  }

  void _onFocusChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    bool isFocused1 = _focusNode1.hasFocus;
    bool isFocused2 = _focusNode2.hasFocus;
    bool isFocused3 = _focusNode3.hasFocus;
    bool isFocused4 = _focusNode4.hasFocus;
    bool isFocused5 = _focusNode5.hasFocus;
    bool isFocused6 = _focusNode6.hasFocus;
    bool isFocused7 = _focusNode7.hasFocus;
    bool isFocused8 = _focusNode8.hasFocus;
    bool isFocused9 = _focusNode8.hasFocus;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        forceMaterialTransparency: true,
        // scrolledUnderElevation: 10,
        title: const Text(
          "Sign Up",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            fontFamily: "Satoshi",
          ),
        ),
        elevation: 0,
        // backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
          child: Column(children: [
        const Center(
            child: Text(
          "Enter Details",
          style: TextStyle(
              fontFamily: "Satoshi",
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Color(0xFFF65734)),
        )),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: TextFormField(
                focusNode: _focusNode1,
                style: const TextStyle(color: Color(0xFF000000), fontSize: 16),
                cursorColor: const Color(0xFF000000),
                controller: firstname,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(
                      'assets/person.svg',
                      color: isFocused1
                          ? const Color(0xFFF65734)
                          : const Color(0xFFE0E0E5),
                    ),
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xFFF65734)),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  // labelText: 'Email',
                  hintText: "First Name",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                        color: Color(0xFFF3F3F3)), // change border color
                  ),
                  labelStyle: const TextStyle(),
                  hintStyle: const TextStyle(
                      color: Color(0xFFA7A9B7),
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      fontFamily: "Satoshi"),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: TextFormField(
                focusNode: _focusNode2,
                style: const TextStyle(color: Color(0xFF000000), fontSize: 16),
                cursorColor: const Color(0xFF000000),
                controller: middleName,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(
                      'assets/person.svg',
                      color: isFocused2
                          ? const Color(0xFFF65734)
                          : const Color(0xFFE0E0E5),
                    ),
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xFFF65734)),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  // labelText: 'Email',
                  hintText: "Middel Name",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                        color: Color(0xFFF3F3F3)), // change border color
                  ),
                  labelStyle: const TextStyle(),
                  hintStyle: const TextStyle(
                      color: Color(0xFFA7A9B7),
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      fontFamily: "Satoshi"),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: TextFormField(
                focusNode: _focusNode3,
                style: const TextStyle(color: Color(0xFF000000), fontSize: 16),
                cursorColor: const Color(0xFF000000),
                controller: lastname,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(
                      'assets/person.svg',
                      color: isFocused3
                          ? const Color(0xFFF65734)
                          : const Color(0xFFE0E0E5),
                    ),
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xFFF65734)),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  // labelText: 'Email',
                  hintText: "Last Name",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                        color: Color(0xFFF3F3F3)), // change border color
                  ),
                  labelStyle: const TextStyle(),
                  hintStyle: const TextStyle(
                      color: Color(0xFFA7A9B7),
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      fontFamily: "Satoshi"),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: TextFormField(
                focusNode: _focusNode4,
                style: const TextStyle(color: Color(0xFF000000), fontSize: 16),
                cursorColor: const Color(0xFF000000),
                controller: email,
                // keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(
                      'assets/sms.svg',
                      color: isFocused4
                          ? const Color(0xFFF65734)
                          : const Color(0xFFE0E0E5),
                    ),
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xFFF65734)),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  // labelText: 'Email',
                  hintText: "Email",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                        color: Color(0xFFF3F3F3)), // change border color
                  ),
                  labelStyle: const TextStyle(),
                  hintStyle: const TextStyle(
                      color: Color(0xFFA7A9B7),
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      fontFamily: "Satoshi"),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return 'Please enter your email address';
                  } else if (isValidEmail(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
                onSaved: (value) {
                  email = value!.trim() as TextEditingController;
                },
              ),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: TextFormField(
                validator: validatePhoneNumber,
                focusNode: _focusNode5,
                style: const TextStyle(color: Color(0xFF000000), fontSize: 16),
                cursorColor: const Color(0xFF000000),
                controller: phone,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(
                      'assets/phone.svg',
                      color: isFocused5
                          ? const Color(0xFFF65734)
                          : const Color(0xFFE0E0E5),
                    ),
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xFFF65734)),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  // labelText: 'Email',
                  hintText: "Phone Number",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                        color: Color(0xFFF3F3F3)), // change border color
                  ),
                  labelStyle: const TextStyle(),
                  hintStyle: const TextStyle(
                      color: Color(0xFFA7A9B7),
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      fontFamily: "Satoshi"),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: DropdownButtonFormField<String>(
            iconDisabledColor: Colors.transparent,
            iconEnabledColor: Colors.transparent,
            value: _slectedGenderId,
            onChanged: (newValue) {
              setState(() {
                _slectedGenderId = newValue;
                print(" _slectedGenderId $_slectedGenderId");
              });
            },
            items: getGenderListModels.data?.map((gender) {
                  return DropdownMenuItem<String>(
                    value: gender.genderId,
                    child: Text(gender.gender ?? ''),
                  );
                }).toList() ??
                [],
            focusNode: _focusNode6,
            decoration: InputDecoration(
              suffixIcon: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset("assets/arrowDown1.svg"),
                  ),
                ],
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xFFF65734)),
                borderRadius: BorderRadius.circular(15.0),
              ),
              hintText: "Gender",
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  color: Color(0xFFF3F3F3),
                ),
              ),
              hintStyle: const TextStyle(
                color: Color(0xFFA7A9B7),
                fontSize: 16,
                fontWeight: FontWeight.w300,
                fontFamily: "Satoshi",
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              prefixIcon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(
                  'assets/gender.svg',
                  color: isFocused6
                      ? const Color(0xFFF65734)
                      : const Color(0xFFE0E0E5),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: TextFormField(
                focusNode: _focusNode7,
                readOnly: true,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xFFF65734)),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  hintText: "Nationality",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                      color: Color(0xFFF3F3F3),
                    ),
                  ),
                  hintStyle: const TextStyle(
                    color: Color(0xFFA7A9B7),
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    fontFamily: "Satoshi",
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(
                      'assets/flag.svg',
                      color: isFocused7
                          ? const Color(0xFFF65734)
                          : const Color(0xFFE0E0E5),
                    ),
                  ),
                ),
                onTap: () {
                  showCountryPicker(
                    context: context,
                    countryListTheme: CountryListThemeData(
                      flagSize: 25,
                      backgroundColor: Colors.white,
                      textStyle:
                          const TextStyle(fontSize: 16, color: Colors.blueGrey),
                      bottomSheetHeight: 500,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                      inputDecoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset(
                            'assets/flag.svg',
                            color: isFocused7
                                ? const Color(0xFFF65734)
                                : const Color(0xFFE0E0E5),
                          ),
                        ),

                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Color(0xFFF65734)),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        // labelText: 'Email',
                        hintText: "Country Name",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                              color: Color(0xFFF3F3F3)), // change border color
                        ),
                        labelStyle: const TextStyle(),
                        hintStyle: const TextStyle(
                            color: Color(0xFFA7A9B7),
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            fontFamily: "Satoshi"),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                      ),
                    ),
                    onSelect: (Country country) {
                      setState(() {
                        _selectedCountry = country;
                        print(
                            'Selected country: ${country.displayNameNoCountryCode}');
                        print(_selectedCountry);
                      });
                    },
                  );
                },
                controller: TextEditingController(
                  text: _selectedCountry != null
                      ? _selectedCountry?.displayNameNoCountryCode
                      : '',
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        Row(
          children: [
            const SizedBox(width: 10),
            Expanded(
              child: TextFormField(
                focusNode: _focusNode8,
                controller: dob,
                readOnly: true, // Prevent manual text input
                onTap: () {
                  // Open the date picker when the field is tapped
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1950),
                    lastDate: DateTime(2100),
                  ).then((selectedDate) {
                    if (selectedDate != null) {
                      // Handle the selected date
                      setState(() {
                        dob.text =
                            DateFormat('yyyy-MM-dd').format(selectedDate);
                        // Date.text = DateFormat.yMd().format(selectedDate);
                      });
                    }
                  });
                },
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xFFF65734)),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  hintText: "Date of Birth",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFFF3F3F3)),
                  ),
                  hintStyle: const TextStyle(
                    color: Color(0xFFA7A9B7),
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    fontFamily: "Outfit",
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: GestureDetector(
                    onTap: () {
                      // Open the date picker when the icon is clicked
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      ).then((selectedDate) {
                        if (selectedDate != null) {
                          // Handle the selected date
                          setState(() {
                            // Date.text =
                            // DateFormat.yMd().format(selectedDate);
                            dob.text =
                                DateFormat('yyyy-MM-dd').format(selectedDate);
                          });
                        }
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(7),
                      child: SvgPicture.asset(
                        'assets/calendar.svg',
                        color: isFocused8
                            ? const Color(0xFFF65734)
                            : const Color(0xFFE0E0E5),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        const Padding(
          padding: EdgeInsets.only(left: 12),
          child: Row(
            children: [
              Text(
                "Number Of Pages",
                style: TextStyle(
                    fontFamily: "Satoshi",
                    fontWeight: FontWeight.w500,
                    fontSize: 16),
              ),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isSelected1 = true;
                        _isSelected2 = false;
                        _isSelected3 = false;
                        selectedPageText = "24";
                      });
                    },
                    child: Container(
                      height: 43,
                      width: 98,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: _isSelected1
                                ? [
                                    const Color(0xFFFF8D74),
                                    const Color(0xFFF65734)
                                  ]
                                : [Colors.white, Colors.white],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: _isSelected1
                                ? const Color(0xFFF65734)
                                : const Color(0xFFE0E0E5),
                          )),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Pages 24",
                            style: TextStyle(
                              color: _isSelected1
                                  ? const Color(0xFFFFFFFF)
                                  : const Color(0xFFA7A9B7),
                              fontFamily: "Satoshi",
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isSelected1 = false;
                        _isSelected2 = true;
                        _isSelected3 = false;
                        selectedPageText = "48";
                      });
                    },
                    child: Container(
                      height: 43,
                      width: 98,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: _isSelected2
                                ? [
                                    const Color(0xFFFF8D74),
                                    const Color(0xFFF65734)
                                  ]
                                : [Colors.white, Colors.white],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: _isSelected2
                                ? const Color(0xFFF65734)
                                : const Color(0xFFE0E0E5),
                          )),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Pages 48",
                            style: TextStyle(
                                color: _isSelected2
                                    ? const Color(0xFFFFFFFF)
                                    : const Color(0xFFA7A9B7),
                                fontFamily: "Satoshi",
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isSelected1 = false;
                        _isSelected2 = false;
                        _isSelected3 = true;
                        selectedPageText = "96";
                      });
                    },
                    child: Container(
                      height: 43,
                      width: 98,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: _isSelected3
                                ? [
                                    const Color(0xFFFF8D74),
                                    const Color(0xFFF65734)
                                  ]
                                : [Colors.white, Colors.white],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: _isSelected3
                                ? const Color(0xFFF65734)
                                : const Color(0xFFE0E0E5),
                          )),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Pages 96",
                            style: TextStyle(
                                color: _isSelected3
                                    ? const Color(0xFFFFFFFF)
                                    : const Color(0xFFA7A9B7),
                                fontFamily: "Satoshi",
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              if (selectedPageText.isNotEmpty)
                Text(
                  selectedPageText,
                  style: const TextStyle(
                    fontFamily: "Satoshi",
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFFA7A9B7),
                  ),
                ),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        Row(
          children: [
            const SizedBox(width: 10),
            Expanded(
              child: DropdownButtonFormField<String>(
                iconDisabledColor: Colors.transparent,
                iconEnabledColor: Colors.transparent,
                value: _selectedcurrency,
                onChanged: (newValue) {
                  setState(() {
                    _selectedcurrency = newValue;
                    print("_selectedcurrency $_selectedcurrency");
                  });
                },
                items: currencyModel.data?.map((currency) {
                      return DropdownMenuItem<String>(
                        value: currency.currencyId,
                        child: Text(currency.currencyCode ?? ''),
                      );
                    }).toList() ??
                    [],
                decoration: InputDecoration(
                  suffixIcon: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset("assets/arrowDown1.svg"),
                      ),
                    ],
                  ),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(
                      'assets/currency.svg',
                      color: isFocused9
                          ? const Color(0xFFF65734)
                          : const Color(0xFFE0E0E5),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xFFF65734)),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  hintText: "Currency",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                      color: Color(0xFFF3F3F3),
                    ),
                  ),
                  hintStyle: const TextStyle(
                    color: Color(0xFFA7A9B7),
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    fontFamily: "Satoshi",
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Stack(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () async {
                    print(firstname.text);
                    print(middleName.text);
                    print(lastname.text);
                    print(email.text);
                    print(phone.text);
                    print(_slectedGenderId);

                    print(_selectedCountry?.displayNameNoCountryCode);
                    print(dob.text);
                    print(selectedPageText);

                    print("Sign Up Button Pressed");
                    if (firstname.text.isNotEmpty &&
                        middleName.text.isNotEmpty &&
                        lastname.text.isNotEmpty &&
                        dob.text.isNotEmpty &&
                        _selectedCountry != null &&
                        _slectedGenderId != null &&
                        _selectedcurrency != null) {
                      setState(() {
                        isLoading = true; // Show the progress indicator
                      });
                      await signUpUser();
                      setState(() {
                        isLoading = false; // Show the progress indicator
                      });
                      if (signUpDetailsModel.status == "success") {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (BuildContext context) {
                            return MainScreen(
                              userId: widget.userId,
                            );
                          },
                        ));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Something Went Wrong!"),
                            backgroundColor: Color(0xFFF65734),
                          ),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please Put all the Data!"),
                          backgroundColor: Color(0xFFF65734),
                        ),
                      );
                    }
                  },
                  child: Container(
                    height: 48,
                    width: MediaQuery.of(context).size.width * 0.94,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFF65734), Color(0xFFFF8D74)],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Sign Up",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Satoshi",
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            if (isLoading) // Show the circular progress indicator if isLoading is true
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              ),
          ]),
        ),
      ])),
    );
  }

  bool isValidEmail(String email) {
    String pattern =
        r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$'; // Email regex pattern
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(email);
  }

  String? validatePhoneNumber(String? value) {
    if (value == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please Enter Valid the Number"),
        ),
      );
    }

    // Customize the phone number validation logic here
    if (value!.length != 11) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please Enter a Valid Number"),
        ),
      );
    }

    return null; // Return null if the validation succeeds
  }

  bool _isSelected1 = false;
  bool _isSelected2 = false;
  bool _isSelected3 = false;
  String selectedPageText = "";

  Country? _selectedCountry;

  String? phoneNumber;
  String? selectedOption;
}
