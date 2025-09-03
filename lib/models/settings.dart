class Settings {
  bool showSeconds;
  bool showDate;
  String theme;

  Settings({
    required this.showSeconds,
    required this.showDate,
    required this.theme,
  });

  // Factory for default settings
  factory Settings.defaultSettings() {
    return Settings(
      showSeconds: true,
      showDate: true,
      theme: 'retro',
    );
  }

  // From JSON
  factory Settings.fromJson(Map<String, dynamic> json) {
    return Settings(
      showSeconds: json['showSeconds'] ?? true,
      showDate: json['showDate'] ?? true,
      theme: json['theme'] ?? 'retro',
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'showSeconds': showSeconds,
      'showDate': showDate,
      'theme': theme,
    };
  }
}