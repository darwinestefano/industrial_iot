class Dust {
  //final String deviceId;
  String datestamp;
  String timestamp;
  int dust;

  Dust(this.datestamp, this.timestamp, this.dust);

  Dust.fromMap(Map<String, dynamic> map)
      : datestamp = map['datestamp'],
        timestamp = map['timestamp'],
        dust = map['dust'];

  @override
  String toString() => "$dust";
}
