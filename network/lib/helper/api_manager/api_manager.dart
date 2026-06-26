part of '../../network.dart';

abstract class _ApiHandler {
  Future<Response?> callPost({required String url,  Map<String, dynamic>? body, Map<String, String>? params});

  Future<Response?> callPut({required String url, Map<String, dynamic>? body, Map<String, String>? params});

  Future<Response?> callMultipart({
    required String url,
    Map<String, dynamic>? body,
    Map<String, String>? params,
    required MultiPartType type,
    required List<File> files,
    required String fileKey,
  });

  Future<Response?> callPatch({required String url,  Map<String, dynamic>? body, Map<String, String>? params});

  Future<Response?> callDelete({required String url, Map<String, dynamic>? body, Map<String, String>? params});

  Future<Response?> callGet({required String url, Map<String, String>? params});
}

class ApiManager extends _ApiHandler {
  final Dio _dio = DioClient.instance;

  @override
  Future<Response?> callDelete({required String url, Map<String, dynamic>? body, Map<String, String>? params}) async {
    try {
      final response = await _dio.delete(url, data: body, queryParameters: params);
      return response;
    } on DioException catch (e) {
      Log.error(e);
      throw e.error ?? DefaultException(message: "Some thing went wrong");
    } catch (e) {
      Log.error(e);
      rethrow;
    }
  }

  @override
  Future<Response?> callGet({required String url, Map<String, String>? params}) async {
    try {
      final response = await _dio.get(url, queryParameters: params);
      return response;
    } on DioException catch (e) {
      Log.error(e);
      throw e.error ?? DefaultException(message: "Some thing went wrong");
    } catch (e) {
      Log.error(e);
      rethrow;
    }
  }

  @override
  Future<Response?> callPatch({required String url,  Map<String, dynamic>? body, Map<String, String>? params}) async {
    try {
      final response = await _dio.patch(url, data: body, queryParameters: params);
      return response;
    } on DioException catch (e) {
      Log.error(e);
      throw e.error ?? DefaultException(message: "Some thing went wrong");
    } catch (e) {
      Log.error(e);
      rethrow;
    }
  }

  @override
  Future<Response?> callPost({required String url,  Map<String, dynamic>? body, Map<String, String>? params}) async {
    try {
      final response = await _dio.post(url, data: body, queryParameters: params);
      return response;
    } on DioException catch (e) {
      Log.error(e);
      throw e.error ?? DefaultException(message: "Some thing went wrong");
    } catch (e) {
      Log.error(e);
      rethrow;
    }
  }

  @override
  Future<Response?> callPut({required String url, Map<String, dynamic>? body, Map<String, String>? params}) async {
    try {
      final response = await _dio.put(url, data: body, queryParameters: params);
      return response;
    } on DioException catch (e) {
      Log.error(e);
      throw e.error ?? DefaultException(message: "Some thing went wrong");
    } catch (e) {
      Log.error(e);
      rethrow;
    }
  }
  @override
  Future<Response?> callMultipart({
    required String url,
    Map<String, dynamic>? body,
    Map<String, String>? params,
    required MultiPartType type,
    List<File>? files,
    List<Uint8List>? bytesList,
    List<String>? byteFileNames,
    required String fileKey,
  }) async {
    try {
      final formData = FormData();

      // Handle File list
      if (files != null) {
        for (final file in files) {
          if (await file.exists()) {
            formData.files.add(MapEntry(
              fileKey,
              await MultipartFile.fromFile(
                file.path,
                filename: file.path.split('/').last,
              ),
            ));
          }
        }
      }

      // Handle Uint8List list
      if (bytesList != null) {
        for (int i = 0; i < bytesList.length; i++) {
          final filename = byteFileNames != null && i < byteFileNames.length
              ? byteFileNames[i]
              : 'file_$i';

          formData.files.add(MapEntry(
            fileKey,
            MultipartFile.fromBytes(bytesList[i], filename: filename),
          ));
        }
      }

      if (body != null && body.isNotEmpty) {
        formData.fields.addAll(body.entries.map((e) => MapEntry(e.key, e.value.toString())));
      }

      final response = await _dio.request(
        url,
        data: formData,
        queryParameters: params,
        options: Options(method: type.value),
      );

      return response;
    } on DioException catch (e) {
      Log.error(e);
      throw e.error ?? DefaultException(message: "Some thing went wrong");
    } catch (e) {
      Log.error(e);
      rethrow;
    }
  }
}

enum MultiPartType {
  post(value: 'POST'),
  put(value: 'PUT');

  final String value;

  const MultiPartType({required this.value});
}
