// IZebraSensor.aidl
package com.zebra.zsfinder;

/**
*  AIDL interface for interacting with Zebra ZS series sensors.
*  Generally, methods starting with "get" will retrieve data stored locally in the service, while
*  methods starting with "read" or "write" will connect to and communicate with the sensor over
*  Bluetooth LE. Connecting to a sensor will stop any Bluetooth LE scans currently in progress and
*  will prevent new scans from starting until communication is complete. Only a single sensor
*  will be connected to at a time. A connection to a sensor will remain open after communication is
*  complete until a connnection to a different sensor is requested or a new Bluetooth LE scan is initiated.
*/
interface IZebraSensor {
    /**
    * 1 - Value for temperature sensor
    */
    const int SENSOR_TYPE_TEMPERATURE = 1;
    /**
    * 0 - No alert.&nbsp;Turn LED off.
    */
    const int ALERT_LEVEL_NONE = 0;
    /**
    * 1 - Mild alert.&nbsp;Trigger LED flash pattern.&nbsp;Used to provide task status.
    */
    const int ALERT_LEVEL_MILD = 1;
    /**
    * 2 - High alert.&nbsp;Same as mild alert.
    */
    const int ALERT_LEVEL_HIGH = 2;

    /**
     * Get the MAC address of the discovered sensor.&nbsp;This call does not connect to the sensor.
     * @return MAC address of sensor.
     * @throws RemoteException
     */
    String getMACAddress();
    /**
     * Get the device ID of the discovered sensor.&nbsp;This call does not connect to the sensor.
     * @return ID of sensor.
     * @throws RemoteException
     */
    String getId();
    /**
     * Get the RSSI of the discovered sensor at time of discovery.&nbsp;This call does not connect to the sensor.
     * @return RSSI of sensor.
     * @throws RemoteException
     */
    int getRssi();
    /**
    * Get the sensor friendly name.&nbsp;This call does not connect to the sensor.
    * @return Friendly name of sensor.
    * @throws RemoteException
    */
    String getFriendlyName();
    /**
    * Get the raw advertising info bytes broadcasted by this sensor.&nbsp;This call does not connect to the sensor.
    * @return Advertising info byte array.
    * @throws RemoteException
    */
    byte[] getAdvertisingInfo();
    /**
    * Get the value of the last sample, which is included in the Advertising Info.&nbsp;This call does not connect to the sensor.
    * @return Last sample included in the last Advertising Info broadcast received.
    * @throws RemoteException
    */
    float getLastSampledTemperature();
    /**
    * Get the timestamp of the last time this sensor was seen during sensor discovery.&nbsp;This call does not connect to the sensor.
    * @return Timestamp of when this sensor was last discovered.
    * @throws RemoteException
    */
    String getLastDiscovered();
    /**
    * Get the sensor type included in the Advertising Info broadcast.&nbsp;This call does not connect to the sensor.
    * @return Sensor type included in the last Advertising Info broadcast received.
    * @throws RemoteException
    */
    int getSensorType();
    /**
    * Connect to and read the battery level of the sensor.
    * @return The battery level of the sensor as a percentage out of 100.
    * @throws RemoteException
    */
    int readBatteryLevel();
    /**
    * Connect to and read the current temperature value measured by the sensor.
    * @return The current temperature value reported by the sensor.
    * @throws RemoteException
    */
    float readTemperature();
    /**
    * Connect to and write the alert level of the sensor.
    * @param level The level of the alert to set. Accepted values are {@link #ALERT_LEVEL_NONE}, {@link #ALERT_LEVEL_MILD}, or {@link #ALERT_LEVEL_HIGH}.
    * @throws RemoteException
    */
    void writeAlertLevel(int level);
    /**
    * @deprecated This method is no longer supported and will throw an Exception if used.
    * @param firmware The firmware to send to the sensor.
    * @throws RemoteException
    */
    void writeFirmware(in byte[] firmware);
    /**
    * Connect to and read the temperature samples logged on the sensor.
    * @return The temperature samples as an array of floats.
    * @throws RemoteException
    */
    float[] readTemperatureSamples();
    /**
    * Get the number of temperature samples stored on the sensor, which is included in the Advertising Info.&nbsp;This call does not connect to the sensor.
    * @return Number of temperature samples stored on the sensor.
    * @throws RemoteException
    */
    int getTemperatureSamplesCount();
    /**
    * Get the number of humidity samples stored on the sensor, which is included in the Advertising Info.&nbsp;This call does not connect to the sensor.
    * @return Number of humidity samples stored on the sensor.
    * @throws RemoteException
    */
    int getHumiditySamplesCount();
    /**
    * Get the number of pressure samples stored on the sensor, which is included in the Advertising Info.&nbsp;This call does not connect to the sensor.
    * @return Number of pressure samples stored on the sensor.
    * @throws RemoteException
    */
    int getPressureSamplesCount();
    /**
    * Get the number of light samples stored on the sensor, which is included in the Advertising Info.&nbsp;This call does not connect to the sensor.
    * @return Number of light samples stored on the sensor.
    * @throws RemoteException
    */
    int getLightSamplesCount();
    /**
    * Get the number of inertia samples stored on the sensor, which is included in the Advertising Info.&nbsp;This call does not connect to the sensor.
    * @return Number of inertia samples stored on the sensor.
    * @throws RemoteException
    */
    int getInertialSamplesCount();
    /**
    * Get the sensor status as decimal value, which is included in the Advertising Info.&nbsp;This call does not connect to the sensor.
    * @return Sensor status.<br>
    * Bits 02:00 - Temperature Sensor<br>
    * Bits 05:03 - Humidity Sensor<br>
    * Bits 08:06 - Pressure Sensor<br>
    * Bits 11:09 - Light Sensor<br>
    * Bits 14:12 - Inertial Sensor<br>
    * Bit  15    - Alarm<br><br>
    * Sensor Status Codes:<br>
    * <table border="1">
    * <thead><tr><td>Code&nbsp;</td><td>Description</td></tr></thead>
    * <tbody>
    * <tr><td>0</td><td>Sensor not present/not supported</td></tr>
    * <tr><td>1</td><td>Stopped - no longer sampling data</td></tr>
    * <tr><td>2</td><td>Started - data sampling has started</td></tr>
    * <tr><td>3</td><td>Waiting for delayed start</td></tr>
    * <tr><td>4</td><td>Started with all data uploaded to cloud</td></tr>
    * <tr><td>5</td><td>Stopped with all data uploaded to the cloud</td></tr>
    * <tr><td>6</td><td>Delivered - used in offline mode to indicate that, while data sampling may still be ongoing, a timestamp was stored to indicate when the Datalogger was delivered. This state is only entered when the Datalogger receives a ZESS Control Characteristic write request with a control event 7.</td></tr>
    * <tr><td>7</td><td>Reserved</td></tr>
    * </tbody>
    * </table>
    * @throws RemoteException
    */
    int getSensorStatus();
    /**
    * Get the battery level of the sensor included in the Advertising Info.&nbsp;This call does not connect to the sensor
    * @return The battery level as an integer representing the percentage out of 100
    */
    int getBatteryLevel();
    /**
    * Get the current alarm state, which is included in the Advertising Info.&nbsp;This call does not connect to te sensor.
    * @return value for alarm status. - 0:INACTIVE  1:ACTIVE
    */
    int getAlarmStatus();
    /**
    * Get the current temperature sensor status, which is included in the Advertising Info.&nbsp;This call does not connect to the sensor.
    * @return Value for temperature sensor status.<br><br>
    * Sensor Status Codes:<br>
    * <table border="1">
    * <thead><tr><td>Code&nbsp;</td><td>Description</td></tr></thead>
    * <tbody>
    * <tr><td>0</td><td>Sensor not present/not supported</td></tr>
    * <tr><td>1</td><td>Stopped - no longer sampling data</td></tr>
    * <tr><td>2</td><td>Started - data sampling has started</td></tr>
    * <tr><td>3</td><td>Waiting for delayed start</td></tr>
    * <tr><td>4</td><td>Started with all data uploaded to cloud</td></tr>
    * <tr><td>5</td><td>Stopped with all data uploaded to the cloud</td></tr>
    * <tr><td>6</td><td>Delivered - used in offline mode to indicate that, while data sampling may still be ongoing, a timestamp was stored to indicate when the Datalogger was delivered. This state is only entered when the Datalogger receives a ZESS Control Characteristic write request with a control event 7.</td></tr>
    * <tr><td>7</td><td>Reserved</td></tr>
    * </tbody>
    * </table>
    */
    int getTemperatureSensorStatus();
    /**
    * Get the current humidity sensor status, which is included in the Advertising Info.&nbsp;This call does not connect to the sensor.
    * @return Value for humidity sensor status.<br><br>
    * Sensor Status Codes:<br>
    * <table border="1">
    * <thead><tr><td>Code&nbsp;</td><td>Description</td></tr></thead>
    * <tbody>
    * <tr><td>0</td><td>Sensor not present/not supported</td></tr>
    * <tr><td>1</td><td>Stopped - no longer sampling data</td></tr>
    * <tr><td>2</td><td>Started - data sampling has started</td></tr>
    * <tr><td>3</td><td>Waiting for delayed start</td></tr>
    * <tr><td>4</td><td>Started with all data uploaded to cloud</td></tr>
    * <tr><td>5</td><td>Stopped with all data uploaded to the cloud</td></tr>
    * <tr><td>6</td><td>Delivered - used in offline mode to indicate that, while data sampling may still be ongoing, a timestamp was stored to indicate when the Datalogger was delivered. This state is only entered when the Datalogger receives a ZESS Control Characteristic write request with a control event 7.</td></tr>
    * <tr><td>7</td><td>Reserved</td></tr>
    * </tbody>
    * </table>
    */
    int getHumiditySensorStatus();
    /**
    * Get the current pressure sensor status, which is included in the Advertising Info.&nbsp;This call does not connect to the sensor.
    * @return Value for pressure sensor status.<br><br>
    * Sensor Status Codes:<br>
    * <table border="1">
    * <thead><tr><td>Code&nbsp;</td><td>Description</td></tr></thead>
    * <tbody>
    * <tr><td>0</td><td>Sensor not present/not supported</td></tr>
    * <tr><td>1</td><td>Stopped - no longer sampling data</td></tr>
    * <tr><td>2</td><td>Started - data sampling has started</td></tr>
    * <tr><td>3</td><td>Waiting for delayed start</td></tr>
    * <tr><td>4</td><td>Started with all data uploaded to cloud</td></tr>
    * <tr><td>5</td><td>Stopped with all data uploaded to the cloud</td></tr>
    * <tr><td>6</td><td>Delivered - used in offline mode to indicate that, while data sampling may still be ongoing, a timestamp was stored to indicate when the Datalogger was delivered. This state is only entered when the Datalogger receives a ZESS Control Characteristic write request with a control event 7.</td></tr>
    * <tr><td>7</td><td>Reserved</td></tr>
    * </tbody>
    * </table>
    */
    int getPressureSensorStatus();
    /**
    * Get the current light sensor status, which is included in the Advertising Info.&nbsp;This call does not connect to the sensor.
    * @return Value for light sensor status.<br><br>
    * Sensor Status Codes:<br>
    * <table border="1">
    * <thead><tr><td>Code&nbsp;</td><td>Description</td></tr></thead>
    * <tbody>
    * <tr><td>0</td><td>Sensor not present/not supported</td></tr>
    * <tr><td>1</td><td>Stopped - no longer sampling data</td></tr>
    * <tr><td>2</td><td>Started - data sampling has started</td></tr>
    * <tr><td>3</td><td>Waiting for delayed start</td></tr>
    * <tr><td>4</td><td>Started with all data uploaded to cloud</td></tr>
    * <tr><td>5</td><td>Stopped with all data uploaded to the cloud</td></tr>
    * <tr><td>6</td><td>Delivered - used in offline mode to indicate that, while data sampling may still be ongoing, a timestamp was stored to indicate when the Datalogger was delivered. This state is only entered when the Datalogger receives a ZESS Control Characteristic write request with a control event 7.</td></tr>
    * <tr><td>7</td><td>Reserved</td></tr>
    * </tbody>
    * </table>
    */
    int getLightSensorStatus();
    /**
    * Get the current inertial sensor status, which is included in the Advertising Info.&nbsp;This call does not connect to the sensor.
    * @return Value for inertial sensor status.<br><br>
    * Sensor Status Codes:<br>
    * <table border="1">
    * <thead><tr><td>Code&nbsp;</td><td>Description</td></tr></thead>
    * <tbody>
    * <tr><td>0</td><td>Sensor not present/not supported</td></tr>
    * <tr><td>1</td><td>Stopped - no longer sampling data</td></tr>
    * <tr><td>2</td><td>Started - data sampling has started</td></tr>
    * <tr><td>3</td><td>Waiting for delayed start</td></tr>
    * <tr><td>4</td><td>Started with all data uploaded to cloud</td></tr>
    * <tr><td>5</td><td>Stopped with all data uploaded to the cloud</td></tr>
    * <tr><td>6</td><td>Delivered - used in offline mode to indicate that, while data sampling may still be ongoing, a timestamp was stored to indicate when the Datalogger was delivered. This state is only entered when the Datalogger receives a ZESS Control Characteristic write request with a control event 7.</td></tr>
    * <tr><td>7</td><td>Reserved</td></tr>
    * </tbody>
    * </table>
    */
    int getInertialSensorStatus();
}