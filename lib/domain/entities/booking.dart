class Booking {
  final int id;
  final String name;
  final String date;
  final String weather;
  final String urlIcon;
  final String courtId;

  Booking({
    required this.id,
    required this.name,
    required this.date,
    required this.weather,
    required this.urlIcon,
    required this.courtId,
  });

  factory Booking.fromSqliteDatabase(Map<String, dynamic> map) => Booking(
        id: map['id']?.toInt() ?? 0,
        name: map['name'] ?? '',
        date: map['date'] ?? '',
        weather: map['weather'] ?? '',
        urlIcon: map['urlIcon'] ?? '',
        courtId: map['courtId'] ?? '',
      );
}
