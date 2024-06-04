import 'dart:io';

/// Returns the contents of a mock file as a string.
///
/// The file must be located in the `test/src/data/data_sources/mocks` directory, else
/// an [FileSystemException] will be thrown.
String readMock(String path) =>
    File('test/src/data/data_sources/mocks/$path').readAsStringSync();
