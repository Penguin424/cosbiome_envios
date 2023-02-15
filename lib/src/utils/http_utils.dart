import 'package:cosbiome_envios/src/utils/preferences_utils.dart';
import 'package:dio/dio.dart';

class Http {
  static final Http _httpMod = Http._internal();
  factory Http() {
    return _httpMod;
  }
  Http._internal();

  static const String _host = "cosbiome.online";

  static final Map<String, String> _headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
  static final Map<String, String> _headersAuth = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer ${PreferencesUtils.getString("jwt")}',
  };

  static Future<Response> get(
    String path,
    Map<String, dynamic> parameters,
  ) async {
    Uri url = Uri(
      host: _host,
      path: path,
      queryParameters: parameters,
      scheme: 'https',
    );

    Response response = await Dio().get(
      url.toString(),
      options: Options(
        headers: _headersAuth,
      ),
    );

    return response;
  }

  static Future<Response> loginSocialNetwork(
    String path,
    Map<String, dynamic> parameters,
  ) async {
    Uri url = Uri(
      host: _host,
      path: path,
      queryParameters: parameters,
      scheme: 'https',
    );

    Response response = await Dio().get(
      url.toString(),
    );

    return response;
  }

  static Future<Response> post(
    String path,
    String data,
  ) async {
    Uri url = Uri(
      host: _host,
      path: path,
      scheme: 'https',
    );
    Response response = await Dio().post(
      url.toString(),
      data: data,
      options: Options(
        headers: _headersAuth,
      ),
    );

    return response;
  }

  static Future<Response> login(
    String path,
    String data,
  ) async {
    Uri url = Uri(
      host: _host,
      path: path,
      scheme: 'https',
    );

    Response response = await Dio().post(
      url.toString(),
      data: data,
      options: Options(
        headers: _headers,
      ),
    );

    return response;
  }

  static Future<Response> update(
    String path,
    String data,
  ) async {
    Uri url = Uri(
      host: _host,
      path: path,
      scheme: 'https',
    );
    Response response = await Dio().put(
      url.toString(),
      data: data,
      options: Options(
        headers: _headersAuth,
      ),
    );

    return response;
  }

  static Future<Response> delete(
    String path,
    Map<String, dynamic> parameters,
  ) async {
    Uri url = Uri(
      host: _host,
      path: path,
      queryParameters: parameters,
      scheme: 'https',
    );
    Response response = await Dio().delete(
      url.toString(),
      options: Options(
        headers: _headersAuth,
      ),
    );

    return response;
  }

  static Future<String> uploadFileToS3(FormData data) async {
    String host = 'https://cosbiome.s3.us-east-2.amazonaws.com/';

    await Dio().post(
      host,
      data: data,
      options: Options(
        headers: {
          'Content-Type': 'multipart/form-data',
        },
      ),
    );

    return host + data.fields.first.value;
  }
}
