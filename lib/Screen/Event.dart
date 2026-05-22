
class Event {
  String title;
  String date;
  String location;

  Event({required this.title, required this.date, required this.location});

  Map<String, dynamic> toJson() {
    return {"title": title, "date": date, "location": location};
  }

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      title: json['title'],
      date: json['date'],
      location: json['location'],
    );
  }
}
