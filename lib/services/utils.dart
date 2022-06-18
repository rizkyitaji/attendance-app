import 'package:intl/intl.dart';

extension StringExtension on String {
  String capitalize() {
    final str = this;
    final value = str.toLowerCase();
    if (value.contains(' ')) {
      List<String> result = [];
      List<String> split =
          str.contains(',') ? value.split(',')[0].split(' ') : value.split(' ');

      split.forEach((e) {
        result.add(e[0].toUpperCase() + e.substring(1));
      });

      String last = str.contains(',') ? ', ${str.split(',')[1].trim()}' : '';

      return result.join(' ') + last;
    }
    return "${value[0].toUpperCase()}${value.substring(1)}";
  }
}

extension DateTimeExtension on DateTime {
  String formatddMMy() => DateFormat('dd-MM-y').format(this);

  String formatMMMMddy() => DateFormat('MMMM dd, y').format(this);

  String formatMMMMy() => DateFormat('MMMM, y').format(this);

  String formathhmm() => DateFormat('hh:mm aa').format(this);

  String formatMMMMddyhhmm() => DateFormat('MMMM dd, y hh:mm aa').format(this);
}
