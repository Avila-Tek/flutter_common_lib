/// Interface for device storage services.
///
/// This interface should be extended implementing the preferred library for
/// device storage, like
/// [shared_preferences](https://pub.dev/packages/shared_preferences) or
/// [flutter_secure_storage](https://pub.dev/packages/flutter_secure_storage).
abstract class IDeviceStorage {
  /// Stores the provided [value] under the given [key] name.
  Future<void> setValue({
    required String key,
    required String value,
  });

  /// Returns the stored value with the provided [key].
  ///
  /// Returns null if there is no value stored with the provided [key].
  Future<String?> getValue(String key);

  /// Clears the stored value with the provided [key].
  Future<void> deleteValue(String key);
}
