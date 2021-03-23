class Humidity {
  //final String deviceId;
  String datestamp;
  String timestamp;
  int humidity;

  Humidity(this.datestamp, this.timestamp, this.humidity);

  Humidity.fromMap(Map<String, dynamic> map)
      : datestamp = map['datestamp'],
        timestamp = map['timestamp'],
        humidity = map['humidity'];

  @override
  String toString() => "$humidity";
}
