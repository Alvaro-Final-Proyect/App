extension DateFormatting on DateTime {
  String format(){
    final today = DateTime.now();
    final difference = (this.difference(today).inHours / 24).round();

    switch(difference){
      case 0: return 'textToday';
      case 1: return 'textTomorrow';
      case 2: return 'textAfterTomorrow';
      default: return toLocal().getDate();
    }
  }

  String getHour() => '${hour < 10 ? '0$hour' : hour}:${minute < 10 ? '0$minute' : minute}';
  String getDate() => '${day < 10 ? '0$day' : day}/${month < 10 ? '0$month' : month}/$year';
}