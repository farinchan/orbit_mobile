import 'dart:developer';

import 'package:dio/dio.dart';

class ApiServices {
  String _url = "http://10.0.2.2:3000/api";
  Dio dio = Dio();

  Future RegisterEndpoint(FormData data) async {
    try {
      //  FormData formData = FormData.fromMap({
      //     "file":
      //         await MultipartFile.fromFile(file.path, filename:fileName),
      // });
      var response = await dio.post("$_url/anggota/register", data: data);
      log(response.data.toString());

      return response.data;
    } on DioError catch (e) {
      if (e.response!.statusCode == 400) {
        return e.response?.data;
      } else {
        return {
          "status": "failed",
          "message": "Terjadi Kesalahan (Error : ${e.toString()})"
        };
      }
    }
  }
}
