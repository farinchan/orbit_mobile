import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:keanggotaan_orbit/helpers/color.dart';
import 'package:keanggotaan_orbit/providers/auth.dart';
import 'package:keanggotaan_orbit/views/widget/textfield_costum.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Consumer<AuthProvider>(
                builder: (context, state, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.arrow_back_ios))
                        ],
                      ),
                      Text(
                        "Buat Akun",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                      SizedBox(height: 8),
                      Text("Daftar Sebagai Anggota"),
                      SizedBox(height: 12),
                      state.imageRegister != null
                          ? Image.file(
                              state.imageRegister!,
                              width: 100,
                            )
                          : Image.asset(
                              "assets/add_photo.png",
                              width: 100,
                            ),
                      TextButton(
                          onPressed: () {
                            state.pickImage(context);
                          },
                          child: Text("Ambil Foto")),
                      SizedBox(height: 12),
                      TextFieldCustom(
                        label: "Nama",
                        hintText: "Enter Your Name",
                        controller: state.nameRegisterC,
                        errorText: state.nameRegisterE,
                      ),
                      SizedBox(height: 12),
                      TextFieldCustom(
                        label: "Email",
                        hintText: "Enter Your Email",
                        controller: state.emailRegisterC,
                        errorText: state.emailRegisterE,
                      ),
                      SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: TextFieldCustom(
                              label: "Tempat Lahir",
                              hintText: "Masukkan Tempat Lahir mu",
                              controller: state.tempatLahirRegisterC,
                              errorText: state.tempatLahirRegisterE,
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: TextFieldCustom(
                                readOnly: true,
                                label: "Tanggal Lahir",
                                hintText: "Masukkan Tanggal Lahir mu",
                                onTap: () async =>
                                    await state.TanggalLahirdatePicker(context),
                                controller: state.tanggalLahirRegisterC,
                                errorText: state.tanggalLahirRegisterE),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 8),
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(
                              color: kDarkBlueColor,
                            ),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Jenis Kelamin",
                                style: TextStyle(fontSize: 16)),
                            Row(
                              children: [
                                Radio(
                                  visualDensity:
                                      const VisualDensity(vertical: -4),
                                  value: 1,
                                  groupValue: state.radioJenisKelamin,
                                  onChanged: (int? value) {
                                    state.jenisKelaminRadioButton(value!);
                                  },
                                ),
                                const Text("Laki-Laki",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16))
                              ],
                            ),
                            Row(
                              children: [
                                Radio(
                                  visualDensity: VisualDensity(vertical: -4),
                                  value: 2,
                                  groupValue: state.radioJenisKelamin,
                                  onChanged: (int? value) {
                                    // setState(() {
                                    state.jenisKelaminRadioButton(value!);
                                    // });
                                  },
                                ),
                                const Text("Perempuan",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16))
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 12),
                      TextFieldCustom(
                        maxLines: 3,
                        label: "Alamat",
                        hintText: "Masukkan Tempat Lahir mu",
                        controller: state.alamatRegisterC,
                        errorText: state.alamatRegisterE,
                      ),
                      SizedBox(height: 12),
                      DropdownButtonHideUnderline(
                        child: DropdownButtonFormField2(
                          decoration: InputDecoration(
                            errorText: state.fakultasRegisterE,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: kDarkBlueColor),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: kDarkBlueColor),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            isDense: true,
                            contentPadding: EdgeInsets.all(10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          dropdownDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          hint: Text(
                            'Fakultas',
                          ),
                          items: state.ListFakultas.map(
                              (item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  )).toList(),
                          value: state.ValueFakultas,
                          onChanged: (value) {
                            state.fakultasDropdown(value as String);
                          },
                          buttonHeight: 40,
                          buttonWidth: 140,
                          itemHeight: 40,
                        ),
                      ),
                      SizedBox(height: 12),
                      DropdownButtonHideUnderline(
                        child: DropdownButtonFormField2(
                          decoration: InputDecoration(
                            filled: true,
                            errorText: state.prodiRegisterE,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: kDarkBlueColor),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: kDarkBlueColor),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            isDense: true,
                            contentPadding: EdgeInsets.all(10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          dropdownDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          hint: Text(
                            'Program Studi',
                          ),
                          items: state.listProdi
                              .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ))
                              .toList(),
                          value: state.valueProdi,
                          onChanged: (value) {
                            state.prodiDropdown(value as String);
                          },
                          buttonHeight: 40,
                          buttonWidth: 140,
                          itemHeight: 40,
                        ),
                      ),
                      SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 8),
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(
                              color: kDarkBlueColor,
                            ),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Bidang UKM ORBIT yang Diminati",
                                style: TextStyle(fontSize: 16)),
                            Row(
                              children: [
                                Radio(
                                  visualDensity:
                                      const VisualDensity(vertical: -4),
                                  value: 1,
                                  groupValue: state.radioBidang,
                                  onChanged: (int? value) {
                                    // setState(() {
                                    state.BidangRadioButton(value!);
                                    // });
                                  },
                                ),
                                const Text("Robotik",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16))
                              ],
                            ),
                            Row(
                              children: [
                                Radio(
                                  visualDensity: VisualDensity(vertical: -4),
                                  value: 2,
                                  groupValue: state.radioBidang,
                                  onChanged: (int? value) {
                                    state.BidangRadioButton(value!);
                                  },
                                ),
                                const Text("Programming",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16))
                              ],
                            ),
                            Row(
                              children: [
                                Radio(
                                  visualDensity: VisualDensity(vertical: -4),
                                  value: 3,
                                  groupValue: state.radioBidang,
                                  onChanged: (int? value) {
                                    // setState(() {
                                    state.BidangRadioButton(value!);
                                    // });
                                  },
                                ),
                                const Text("Multimedia",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16))
                              ],
                            ),
                            Row(
                              children: [
                                Radio(
                                  visualDensity: VisualDensity(vertical: -4),
                                  value: 4,
                                  groupValue: state.radioBidang,
                                  onChanged: (int? value) {
                                    // setState(() {
                                    state.BidangRadioButton(value!);
                                    // });
                                  },
                                ),
                                const Text("Jaringan",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16))
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 12),
                      TextFieldCustom(
                        label: "Alasan Bergabung Ke UKM ORBIT",
                        hintText: "Alasan Bergabung Ke UKM ORBIT",
                        maxLines: 2,
                        controller: state.alasanRegisterC,
                        errorText: state.alasanRegisterE,
                      ),
                      SizedBox(height: 12),
                      TextFieldCustom(
                        label: "No. Telepon",
                        hintText: "Masukkan Tempat Lahir mu",
                        controller: state.noTelpRegisterC,
                        errorText: state.noTelpRegisterE,
                      ),
                      SizedBox(height: 12),
                      TextFieldCustom(
                          controller: state.passRegisterC,
                          errorText: state.passRegisterE,
                          label: "Password",
                          hintText: "Enter Your Password",
                          isPassword: true),
                      SizedBox(height: 12),
                      TextFieldCustom(
                        controller: state.passRepeatRegisterC,
                        errorText: state.passRepeatRegisterE,
                        label: "Repeat Password",
                        hintText: "Enter Your Password",
                        isPassword: true,
                      ),
                      SizedBox(height: 12),
                      RoundedLoadingButton(
                        child: Text('Register',
                            style: TextStyle(color: Colors.white)),
                        color: kDarkBlueColor,
                        controller: state.btnController,
                        onPressed: () {
                          state.Register(context);
                        },
                      ),
                      SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have An Account?",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          SizedBox(width: 12),
                          Text(
                            "Login",
                            style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      )
                    ],
                  );
                },
              )),
        ),
      ),
    );
  }
}
