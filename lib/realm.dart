import 'package:realm/realm.dart';

import '../models/budget.dart';
import '../models/expense.dart';
import '../models/category.dart';

var _config = Configuration.local([Expense.schema, Category.schema, Budget.schema]);
var realm = Realm(_config);
