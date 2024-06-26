import 'package:scoped_model/scoped_model.dart';

import '../model/tag_model.dart';

mixin TagService on Model {
  List<String> _tagList = [];
  List<String> get tagList => _tagList;

  void addingQRtoTag(String qrResult) {
    _tagList.add(qrResult);
    print("QR RESULT ADDED: $qrResult, LENGTH: ${_tagList.length}");
    notifyListeners();
  }
}

