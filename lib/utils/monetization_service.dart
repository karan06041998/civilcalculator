/// Monetization structure ready for integration.
///
/// Planned integrations:
/// 1. Google AdMob banner ads
/// 2. In-app purchase Pro unlock
class MonetizationService {
  bool _isProUser = false;

  bool get isProUser => _isProUser;

  void unlockPro() {
    _isProUser = true;
  }

  String get bannerAdUnitId {
    // Replace with platform-specific production unit IDs.
    return 'ca-app-pub-xxxxxxxxxxxxxxxx/banner-id';
  }
}
