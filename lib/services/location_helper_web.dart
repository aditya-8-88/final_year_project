import 'dart:async';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

/// Web implementation: uses the browser Geolocation API.
/// Returns a Google Maps link string, or null if denied/unavailable.
Future<String?> getLocationString() async {
  try {
    final completer = Completer<String?>();

    html.window.navigator.geolocation.getCurrentPosition().then((position) {
      final lat = position.coords!.latitude;
      final lng = position.coords!.longitude;
      completer.complete(
        '\n\n📍 My location: https://maps.google.com/?q=$lat,$lng',
      );
    }).catchError((_) {
      completer.complete(null);
    });

    // Timeout after 10 seconds
    return completer.future.timeout(
      const Duration(seconds: 10),
      onTimeout: () => null,
    );
  } catch (_) {
    return null;
  }
}
