import 'package:meta/meta.dart';

import '../provider/api.dart';

class MyRepository {
  final MyApiClient apiClient;

  MyRepository({@required this.apiClient}) : assert(apiClient != null);

  getAll() {
    return apiClient.getAll();
  }

  getId(id) {
    return apiClient.getId(id);
  }



}
