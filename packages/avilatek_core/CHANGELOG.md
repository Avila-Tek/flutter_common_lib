# 1.0.0
Major breaking changes were introduced in this version.
* refactor: (BREAKING) new package structure. avilatek_core is now split up into multiple package modules. As of now, the package contains the following sub-packages: `common`, `http` and `interfaces`.
* refactor: (BREAKING) renamed `IErrorRadarDelegate` to `ErrorRadarDelegate`, `MultiErrorRadarRepository` to `MultiErrorRadar` and removed `IErrorRadarRepository` entirely along with ErrorRadarRepository. 
* refactor: (BREAKING) renamed `HttpHeadersInjector` class and its methods. The class was renamed to `HeadersInjector`  
* refactor: (BREAKING) renamed `IDeviceStorage` to `DeviceStorage`.
* feat: added `PersistentHeadersInjector` class to handle HTTP headers persistence.
* feat: added `SessionHttpClient` class to handle HTTP client persistence.
* feat: added `MultiErrorRadar` class to handle multiple error collection services.
# 0.4.0
* feat: added `IErrorRadarRepository` and `IErrorRadarDelegate` interfaces to handle error collection.
# 0.3.0
* feat: added `App-Version` header to HttpHeaderType enum.