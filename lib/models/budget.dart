import 'package:realm/realm.dart';
import '../types/period.dart';  
part 'budget.g.dart';

@RealmModel()
class $Budget {
  @PrimaryKey()
  late final String period;
  late double amount;

  Period get periodEnum {
    return Period.values.firstWhere((e) => e.toString() == period);
  }

  set periodEnum(Period value) {
    period = value.toString();
  }
}