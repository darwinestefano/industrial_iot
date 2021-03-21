class Temperature {
  //final String deviceId;
  String datestamp;
  String timestamp;
  int temperature;

  Temperature(this.datestamp, this.timestamp, this.temperature);

  Temperature.fromMap(Map<String, dynamic> map)
      : datestamp = map['datestamp'],
        timestamp = map['timestamp'],
        temperature = map['temperature'];

  @override
  String toString() => "$temperature";
}
