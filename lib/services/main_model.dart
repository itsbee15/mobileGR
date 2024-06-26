import 'package:scoped_model/scoped_model.dart';
import './tag_services.dart';
import '../controller/SAPService.dart';

class MainModel extends Model with TagService, SAPService {}
