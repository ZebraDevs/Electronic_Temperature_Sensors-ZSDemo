// IZebraSensorService.aidl
package com.zebra.zsfinder;
import com.zebra.zsfinder.IZebraSensor;

/**
* AIDL interface for interacting with Zebra ZS sensor series Android Service
*/
interface IZebraSensorService {
    /**
    * The major version of the AIDL interface.&nbsp;This value is incremented when an existing method is changed.
    */
    const int VERSION = 2;
    /**
    * Get the major version of the AIDL interface used by the service.
    * @return Major version of service AIDL interface.
    */
    int getServiceInterfaceVersion();
    /**
    * The revision of the AIDL interface.&nbsp;This value is incremented with any change to the interface.
    */
    const int REVISION = 11;
    /**
    * Get the revision of the AIDL interface used by the service.
    * @return Revision of the service AIDL interface
    */
    int getServiceInterfaceRevision();
    /**
    * Check whether the client AIDL version is compatible with the service AIDL version.
    * @param clientVersion The {@link #VERSION} defined by the client's AIDL files.
    * @param clientRevision The {@link #REVISION} defined by the client's AIDL files.
    * @return
    * true if the client {@link #VERSION} is equal to {@link #getServiceInterfaceVersion}
    * AND the client {@link #REVISION} is less than or equal to {@link #getServiceInterfaceRevision}, otherwise returns false.
    */
    boolean isClientCompatibleWithService(int clientVersion, int clientRevision);

    /**
    * Action passed to Intent to bind to the service.
    */
    const String BIND_SERVICE_ACTION = "com.zebra.zsfinder.MAIN";
    /**
    * Package ID passed to Intent.setPackage() to bind to the service.
    */
    const String BIND_SERVICE_PACKAGE = "com.zebra.zsfinder";
    /**
    * Broadcast action sent when a Bluetooth LE discovery has started.
    */
    const String ACTION_DISCOVERY_STARTED = "com.zebra.zsfinder.DISCOVERY_STARTED";
    /**
    * Broadcast action sent when a Bluetooth LE discovery has finished.
    */
    const String ACTION_DISCOVERY_FINISHED = "com.zebra.zsfinder.DISCOVERY_FINISHED";
    /**
    * Broadcast action sent when a Bluetooth LE discovery has encountered an error.
    */
    const String ACTION_DISCOVERY_ERROR = "com.zebra.zsfinder.DISCOVERY_ERROR";
    /**
    * Broadcast action sent when a Bluetooth LE discovery has discovered a sensor.&nbsp;This broadcast includes the sensor ID
    * of the discovered sensor in the Extras with key {@link #EXTRA_DISCOVERED_SENSOR_ID}.
    */
    const String ACTION_DISCOVERY_FOUND_SENSOR = "com.zebra.zsfinder.DISCOVERY_FOUND_SENSOR";
    /**
    * The key used to retrieve the sensor ID from a {@link #ACTION_DISCOVERY_FOUND_SENSOR} broadcast Extras bundle.
    */
    const String EXTRA_DISCOVERED_SENSOR_ID = "com.zebra.zsfinder.EXTRA_DISCOVERED_SENSOR_ID";

    /**
    * Get a list of the devices that have been discovered in the current scan.
    * @return List of sensor IDs for the sensors discovered in the current scan.
    */
    List<String> getCurrentScanDevices();
    /**
    * Get a list of the devices that were discovered in the last completed scan.
    * @return List of sensor IDs for the sensors discovered in the last scan.
    */
    List<String> getLastScanDevices();
    /**
    * Get a list of the devices that have been discovered by the service at any time in the past.
    * @return List of sensor IDs for the sensors discovered by the service.
    */
    List<String> getSeenDevices();
    /**
    * Clear the list of sensor the service has seen in the past.
    */
    void clearSeenDevices();
    /**
    * Get an {@link com.zebra.zsfinder.IZebraSensor} object representing the discovered sensor.&nbsp;
    * Data fields will be populated with the Advertising Info captured when the sensor was discovered.&nbsp;
    * Only sensors that have been discovered by the Bluetooth LE scanner will be returned by this method.
    * @return {@link com.zebra.zsfinder.IZebraSensor} representing the sensor with an ID matching the sensor ID
    * supplied, or null if no sensor with that ID could be found.
    */
    @nullable IZebraSensor getSensor(String sensorId);
    /**
    * Check if Bluetooth LE scanner is enabled.
    * @return true if scanner is enabled, false if it is disabled.
    */
    boolean isBackgroundDiscoveryEnabled();
    /**
    * Check if Bluetooth LE scanner is currently discovering devices.
    * @return true if scanner is currently scanning, false if it is not currently scanning.
    */
    boolean isBackgroundDiscoveryRunning();
    /**
    * Broadcast action sent when the Bluetooth LE scanner has been paused.&nbsp;This usually occurs before a sensor connection is established.
    */
    const String ACTION_DISCOVERY_PAUSED = "com.zebra.zsfinder.DISCOVERY_PAUSED";
    /**
    * Broadcast action sent when the Bluetooth LE scanner has been unpaused.
    */
    const String ACTION_DISCOVERY_UNPAUSED = "com.zebra.zsfinder.DISCOVERY_UNPAUSED";
    /**
    * Broadcast action sent when a Bluetooth LE discovery was unable to run due to insufficient permissoins.
    */
    const String ACTION_DISCOVERY_ERROR_PERMISSIONS = "com.zebra.zsfinder.DISCOVERY_ERROR_PERMISSIONS";
    /**
    * Set the authentication token used to make calls to Zebra back end.&nbsp;This token should be acquired from Zebra API.&nbsp;
    * Only one token can be set in the service at a time.
    * @param token The token used for authenticating.
    */
    void setAuthenticationToken(String token);
    /**
    * Remove the existing authentication token used by the service
    */
    void removeAuthenticationToken();
    /**
    * Broadcast action sent during a sensor seen call failure due to a missing authentication token.
    */
    const String ACTION_DISCOVERY_ERROR_MISSING_AUTH_TOKEN = "com.zebra.zsfinder.DISCOVERY_ERROR_MISSING_AUTH_TOKEN";
    /**
    * Broadcast action sent during a sensor seen call failure due to an invalid authentication token.
    */
    const String ACTION_DISCOVERY_ERROR_INVALID_AUTH_TOKEN = "com.zebra.zsfinder.DISCOVERY_ERROR_INVALID_AUTH_TOKEN";
    /**
    * Checks whether the authentication token has been set in the service.
    * This method does not check the validity of the token stored.
    * @return True if the service has an auth token set, false if auth token is missing or empty.&nbsp;
    */
    boolean hasAuthToken();
    /**
    * Get an {@link com.zebra.zsfinder.IZebraSensor} object representing the discovered sensor.&nbsp;
    * Data fields will be populated with the Advertising Info captured when the sensor was discovered.&nbsp;
    * Only sensors that have been discovered by the Bluetooth LE scanner will be returned by this method.
    * @return {@link com.zebra.zsfinder.IZebraSensor} representing the sensor with a serial number matching the serial number
    * supplied, or null if no sensor with that serial number could be found.
    */
    @nullable IZebraSensor getSensorBySerialNumber(String serialNumber);
    /**
    * Checks whether ZSFinder service has the required permissions.
    * @return True if all required ZSFinder permissions are granted, otherwise false.
    */
    boolean getPermissionsGrantedStatus();
    /**
    * Prioritizes a sensor for processing in the next iteration of sensor seen payload processing.
    * Starts a new scan if there is not an active scan.
    * The sensor is only prioritized for the upcoming scan/sensor seen processing loop.
    * If numerous sensors are prioritized, the final sensor to be prioritized is the top priority.
    * @param sensorId The id of the sensor to prioritize.
    */
    void prioritizeSensor(String sensorId);
}