import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:keanggotaan_orbit/data/api_service.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  final RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();

//TODO: Ini adalah provider Register

  int radioJenisKelamin = 1;
  int radioBidang = 1;

  File? imageRegister;

  final TextEditingController nameRegisterC = TextEditingController();
  final TextEditingController emailRegisterC = TextEditingController();
  final TextEditingController tempatLahirRegisterC = TextEditingController();
  final TextEditingController tanggalLahirRegisterC = TextEditingController();
  final TextEditingController alamatRegisterC = TextEditingController();
  final TextEditingController alasanRegisterC = TextEditingController();
  final TextEditingController noTelpRegisterC = TextEditingController();
  final TextEditingController passRegisterC = TextEditingController();
  final TextEditingController passRepeatRegisterC = TextEditingController();

  String jenisKelamin = "";
  String bidang = "";

  String? nameRegisterE;
  String? emailRegisterE;
  String? tempatLahirRegisterE;
  String? tanggalLahirRegisterE;
  String? alamatRegisterE;
  String? fakultasRegisterE;
  String? prodiRegisterE;
  String? alasanRegisterE;
  String? noTelpRegisterE;
  String? passRegisterE;
  String? passRepeatRegisterE;

  final List<String> ListFakultas = [
    'Fakultas Syariah',
    'Fakultas Tarbiyah dan Ilmu Keguruan',
    'Fakultas Ekonomi dan Bisnis Islam',
    'fakultas Ushuluddin Adab dan Dakwah',
  ];

  String? ValueFakultas;

  List<String> listProdi = [];
  String? valueProdi;

  List<String> listFakultas1 = [
    'Hukum Keluarga',
    'Hukum Ekonomi Syariah',
    'Hukum Tatanegara',
    'Hukum Pidana Islam',
  ];
  List<String> listFakultas2 = [
    'Pendidikan Agama Islam',
    'Pendidikan Bahasa Arab',
    'Pendidikan Bahasa Inggris',
    'Pendidikan Matematika',
    'Pendidikan Teknik Informatika dan Komputer',
    'Bimbingan dan Konseling',
  ];
  List<String> listFakultas3 = [
    'Ekonomi Islam',
    'Perbankan Syariah',
    'Akuntansi Syariah',
    'Pariwisata Syariah',
    'Manajemen Haji dan Umroh',
    'Manajemen Bisnis Syariah',
  ];
  List<String> listFakultas4 = [
    'Ilmu Alquran dan Tafsir',
    'Ilmu Hadist',
    'Komunikasi Penyiaran Islam',
    'Sejarah Peradaban Islam',
    'Aqidah dan Filsafat Islam',
    'Sosiologi Agama',
  ];

  void fakultasDropdown(String fakultas) {
    valueProdi = null;
    ValueFakultas = fakultas;
    listProdi.clear();
    switch (fakultas) {
      case 'Fakultas Syariah':
        listProdi = listFakultas1;
        notifyListeners();
        break;
      case 'Fakultas Tarbiyah dan Ilmu Keguruan':
        listProdi = listFakultas2;
        notifyListeners();
        break;
      case 'Fakultas Ekonomi dan Bisnis Islam':
        listProdi = listFakultas3;
        notifyListeners();
        break;
      case 'fakultas Ushuluddin Adab dan Dakwah':
        listProdi = listFakultas4;
        notifyListeners();
        break;
      default:
        listProdi.clear();
        notifyListeners();
    }
    log(ValueFakultas!);
  }

  void prodiDropdown(String prodi) {
    valueProdi = prodi;
    log(valueProdi!);
  }

  void jenisKelaminRadioButton(int value) {
    radioJenisKelamin = value;
    notifyListeners();
    switch (radioJenisKelamin) {
      case 1:
        jenisKelamin = "laki-laki";
        break;
      case 2:
        jenisKelamin = "perempuan";
        break;
      default:
    }
  }

  void BidangRadioButton(int value) {
    radioBidang = value;
    notifyListeners();
    switch (radioBidang) {
      case 1:
        bidang = "robotik";
        break;
      case 2:
        bidang = "programming";
        break;
      case 3:
        bidang = "multimedia";
        break;
      case 4:
        bidang = "jaringan";
        break;
      default:
    }
  }

  Future<void> TanggalLahirdatePicker(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2100));

    if (pickedDate != null) {
      print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      print(
          formattedDate); //formatted date output using intl package =>  2021-03-16

      tanggalLahirRegisterC.text =
          formattedDate; //set output date to TextField value.
      notifyListeners();
    } else {}
  }

  Future<void> pickImage(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: image.path,
        aspectRatio: CropAspectRatio(ratioX: 3, ratioY: 4),
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Cropper',
          ),
          WebUiSettings(
            context: context,
          ),
        ],
      );
      if (croppedFile != null) {
        imageRegister = File(croppedFile.path);
        notifyListeners();
        log(croppedFile.path);
      }
    }
  }

  void Register(BuildContext context) async {
    if (nameRegisterC.text == "") {
      nameRegisterE = "Nama Harus Diisi";
    } else {
      nameRegisterE = null;
    }

    final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(emailRegisterC.text);

    if (emailRegisterC.text == "") {
      emailRegisterE = "email Ini Harus Diisi";
    } else if (!emailValid) {
      emailRegisterE = "Email ini tidak valid";
    } else {
      emailRegisterE = null;
    }

    if (tempatLahirRegisterC.text == "") {
      tempatLahirRegisterE = "Tempat Lahir Harus Diisi";
    } else {
      tempatLahirRegisterE = null;
    }

    if (tanggalLahirRegisterC.text == "") {
      tanggalLahirRegisterE = "Tanggal Lahir Harus Diisi";
    } else {
      tanggalLahirRegisterE = null;
    }

    if (alamatRegisterC.text == "") {
      alamatRegisterE = "Alamat Harus Diisi";
    } else {
      alamatRegisterE = null;
    }

    if (ValueFakultas == null) {
      fakultasRegisterE = "Fakultas Harus Dipilih";
    } else {
      fakultasRegisterE = null;
    }

    if (valueProdi == null) {
      prodiRegisterE = "Program Studi Harus Dipilih";
    } else {
      prodiRegisterE = null;
    }

    if (alasanRegisterC.text == "") {
      alasanRegisterE = "Alasan Harus Diisi";
    } else {
      alasanRegisterE = null;
    }

    if (noTelpRegisterC.text == "") {
      noTelpRegisterE = "No.Telp Harus Diisi";
    } else {
      noTelpRegisterE = null;
    }

    if (passRegisterC.text == "") {
      passRegisterE = "Password Harus Diisi";
    } else if (passRegisterC.text.length < 8) {
      passRegisterE = "password harus lebih dari 8 karakter";
    } else {
      passRegisterE = null;
    }

    if (passRepeatRegisterC.text == "") {
      passRepeatRegisterE = "Repeat password Harus Diisi";
    } else if (passRepeatRegisterC.text.length < 8) {
      passRepeatRegisterE = "paasword harus lebih dari 8 karakter";
    } else if (passRepeatRegisterC.text != passRegisterC.text) {
      passRepeatRegisterE = "Repeat password harus sama dengan password";
    } else {
      passRepeatRegisterE = null;
    }

    if (nameRegisterE == null &&
        emailRegisterE == null &&
        tempatLahirRegisterE == null &&
        tanggalLahirRegisterE == null &&
        fakultasRegisterE == null &&
        fakultasRegisterE == null &&
        alamatRegisterE == null &&
        alasanRegisterE == null &&
        noTelpRegisterE == null &&
        passRegisterE == null &&
        passRepeatRegisterE == null) {
      Map<String, dynamic> allData = {
        "image": await MultipartFile.fromFile(imageRegister!.path,
            filename: nameRegisterC.text),
        "nama": nameRegisterC.text,
        "email": emailRegisterC.text,
        "tempat_lahir": tempatLahirRegisterC.text,
        "tanggal_lahir": tanggalLahirRegisterC.text,
        "jenis_kelamin": jenisKelamin,
        "alamat": alamatRegisterC.text,
        "fakultas": ValueFakultas,
        "prodi": valueProdi,
        "bidang": bidang,
        "alasan": alasanRegisterC.text,
        "no_telp": noTelpRegisterC.text,
        "password": passRegisterC.text
      };

      log(allData.toString());

      FormData data = FormData.fromMap(allData);
      var res = await ApiServices().RegisterEndpoint(data);

      if (res["status"] == "success") {
        btnController.success();
        context.goNamed("login");
        notifyListeners(  );
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              title: 'Register Berhasil',
              message: "silahkan Login untuk masuk",
              contentType: ContentType.success,
            ),
          ));
      } else {
        btnController.error();
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              title: 'Terjadi Kesalahan',
              message: res["message"],
              contentType: ContentType.failure,
            ),
          ));
        notifyListeners();
        Timer(
          Duration(seconds: 3),
          () {
            btnController.reset();
            notifyListeners();
          },
        );
      }
    } else {
      btnController.error();
      notifyListeners();
      Timer(
        Duration(seconds: 2),
        () {
          btnController.reset();
          notifyListeners();
        },
      );
    }
  }

//TODO: Ini adalah provider untuk Login

  final TextEditingController emailLoginC = TextEditingController();
  final TextEditingController passLoginC = TextEditingController();

  String emailLoginE = '';
  String passLoginE = '';

  Future<void> Login(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();

    final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(emailLoginC.text);

    if (emailLoginC.text == "") {
      emailLoginE = "Field Ini Harus Diisi";
    } else if (!emailValid) {
      emailLoginE = "Email ini tidak valid";
    } else {
      emailLoginE = "";
    }

    if (passLoginC.text == "") {
      passLoginE = "Field Ini Harus Diisi";
    } else if (passLoginC.text.length < 8) {
      passLoginE = "password harus lebih dari 8 karakter";
    } else {
      passLoginE = "";
    }

    // if (emailLoginE == '' && passLoginE == '') {
    //   var res = await ApiServices()
    //       .LoginEndpoint(email: emailLoginC.text, password: passLoginC.text);
    //   if (res["status"] == "success") {
    //     btnController.success();
    //     notifyListeners();
    //     await prefs.setString('token', res["token"]);
    //     context.goNamed("home_page");
    //   } else {
    //     btnController.error();
    //     ScaffoldMessenger.of(context)
    //       ..hideCurrentSnackBar()
    //       ..showSnackBar(SnackBar(
    //         elevation: 0,
    //         behavior: SnackBarBehavior.floating,
    //         backgroundColor: Colors.transparent,
    //         content: AwesomeSnackbarContent(
    //           title: 'Terjadi Kesalahan',
    //           message: res["message"],
    //           contentType: ContentType.failure,
    //         ),
    //       ));
    //     notifyListeners();
    //     Timer(
    //       Duration(seconds: 3),
    //       () {
    //         btnController.reset();
    //         notifyListeners();
    //       },
    //     );
    //   }
    // } else {
    //   btnController.error();
    //   notifyListeners();
    //   Timer(
    //     Duration(seconds: 2),
    //     () {
    //       btnController.reset();
    //       notifyListeners();
    //     },
    //   );
    // }
  }

  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    context.goNamed("onboarding");
  }
}
