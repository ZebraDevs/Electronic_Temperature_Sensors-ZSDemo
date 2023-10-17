package com.zebra.zsdemo

import android.content.*
import android.os.IBinder
import android.os.RemoteException
import android.util.Log
import com.zebra.zsfinder.IZebraSensorService
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import org.json.JSONObject

class MainActivity : FlutterActivity() {

    private val channel = "zebra.com/core"
     private  val EVENT_CHANNEL = "zebra.com/sensor"
    private var zebraService: IZebraSensorService? = null

    private val connection =
            object : ServiceConnection {
                override fun onServiceConnected(className: ComponentName, service: IBinder) {
                    zebraService = IZebraSensorService.Stub.asInterface(service)
                    Log.d("MainActivity", "Remote service Connected")
                }

                override fun onServiceDisconnected(arg0: ComponentName) {
                    Log.d("MainActivity", "Remote service Disconnected")
                    zebraService = null
                }
            }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channel).setMethodCallHandler {
                call,
                result ->
            when (call.method) {
                "getServiceBound" -> {
                    if (zebraService == null) {
                        result.success(false)
                    } else {
                        result.success(true)
                    }
                    return@setMethodCallHandler
                }
                "bindToService" -> {
                    try {
                        val serviceIntent = Intent(IZebraSensorService.BIND_SERVICE_ACTION)
                        serviceIntent.setPackage(IZebraSensorService.BIND_SERVICE_PACKAGE)
                        val bound = context.bindService(serviceIntent, connection, BIND_AUTO_CREATE)
                        result.success(bound)
                        return@setMethodCallHandler
                    } catch (e: RuntimeException) {
                        result.error("ERROR", e.message, null)
                        return@setMethodCallHandler
                    }
                }
                "getSensor" -> {
                    if (zebraService == null) {
                        result.error("Null", "Zebra service has not been initialized", "")
                        return@setMethodCallHandler
                    }

                    val serialNumber: String? = call.argument<String?>("serialNumber")

                    if (serialNumber == null) {
                        result.error("Null", "Sensor ID is NULL", "")
                        return@setMethodCallHandler
                    }

                    try {
                        val res = zebraService?.getSensorBySerialNumber(serialNumber)
                        if (res?.friendlyName == null && res?.macAddress == null && res?.id == null
                        ) {
                            result.error("ERROR", "Could not fetch the sensor information", null)
                            return@setMethodCallHandler
                        }
                        val map: Map<String, Any?> =
                                mapOf(
                                        "friendlyName" to res.friendlyName,
                                        "macAddress" to res.macAddress,
                                        "sensorId" to res.id,
                                        "rssi" to res.rssi,
                                        "lastDiscovered" to res.lastDiscovered,
                                        "advertisingInfo" to res.advertisingInfo,
                                        "batteryLevel" to res.batteryLevel,
                                        "alarmStatus" to res.alarmStatus,
                                        "humiditySamplesCount" to res.humiditySamplesCount,
                                        "humiditySensorStatus" to res.humiditySensorStatus,
                                        "inertialSamplesCount" to res.inertialSamplesCount,
                                        "inertialSensorStatus" to res.inertialSensorStatus,
                                        "lastSampledTemperature" to res.lastSampledTemperature,
                                        "lightSamplesCount" to res.lightSamplesCount,
                                        "lightSensorStatus" to res.lightSensorStatus,
                                        "sensorStatus" to res.sensorStatus,
                                        "sensorType" to res.sensorType,
                                        "pressureSamplesCount" to res.pressureSamplesCount,
                                        "pressureSensorStatus" to res.pressureSensorStatus,
                                        "temperatureSamplesCount" to res.temperatureSamplesCount,
                                        "temperatureSensorStatus" to res.temperatureSensorStatus,
                                )
                        result.success(JSONObject(map).toString())
                        return@setMethodCallHandler
                    } catch (e: IllegalStateException) {
                        result.error("ERROR", e.message, null)
                        return@setMethodCallHandler
                    }
                }
                "getPermissionsGrantedStatus" -> {
                    if (zebraService == null) {
                        result.error("Null", "Zebra service has not been initialized", "")
                        return@setMethodCallHandler
                    }

                    try {
                        val retVal = zebraService?.getPermissionsGrantedStatus()
                        result.success(retVal)
                        return@setMethodCallHandler
                    } catch (e: RemoteException) {
                        result.error("ERROR: getPermissionsGrantedStatus: ", e.message, null)
                        return@setMethodCallHandler
                    }
                }
                "isClientCompatibleWithService" -> {
                    if (zebraService == null) {
                        result.error("Null", "Zebra service has not been initialized", "")
                        return@setMethodCallHandler
                    }

                    val clientVersion: Int? = call.argument<Int?>("clientVersion")
                    val clientRevision: Int? = call.argument<Int?>("clientRevision")

                    if (clientVersion == null || clientRevision == null) {
                        result.error("Null", "clientVersion or clientRevision is null!", "")
                        return@setMethodCallHandler
                    }

                    try {
                        val retVal =
                                zebraService?.isClientCompatibleWithService(
                                        clientVersion,
                                        clientRevision
                                )
                        result.success(retVal)
                        return@setMethodCallHandler
                    } catch (e: RemoteException) {
                        result.error("ERROR: isClientCompatibleWithService: ", e.message, null)
                        return@setMethodCallHandler
                    }
                }
                "clientHasAuthToken" -> {
                    if (zebraService == null) {
                        result.error("Null", "Zebra service has not been initialized", "")
                        return@setMethodCallHandler
                    }

                    try {
                        val retVal = zebraService?.hasAuthToken()
                        result.success(retVal)
                        return@setMethodCallHandler
                    } catch (e: RemoteException) {
                        result.error("ERROR: clientHasAuthToken: ", e.message, null)
                        return@setMethodCallHandler
                    }
                }
                "setAuthToken" -> {
                    if (zebraService == null) {
                        result.error("Null", "Zebra service has not been initialized", "")
                        return@setMethodCallHandler
                    }

                    val authToken: String? = call.argument<String?>("authToken")

                    if (authToken == null) {
                        result.error("Null", "authToken null!", "")
                        return@setMethodCallHandler
                    }

                    try {
                        zebraService?.setAuthenticationToken(authToken)
                        result.success(true)
                        return@setMethodCallHandler
                    } catch (e: RemoteException) {
                        result.error("ERROR: setAuthToken: ", e.message, null)
                        return@setMethodCallHandler
                    }
                }
                "prioritizeSensor" -> {
                    if (zebraService == null) {
                        result.error("Null", "Zebra service has not been initialized", "")
                        return@setMethodCallHandler
                    }

                    val sensorId: String? = call.argument<String?>("sensorId")

                    if (sensorId == null) {
                        result.error("Null", "Sensor ID is NULL", "")
                        return@setMethodCallHandler
                    }

                    try {
                        zebraService?.prioritizeSensor(sensorId)
                        result.success(true)
                        return@setMethodCallHandler
                    } catch (e: RemoteException) {
                        result.error("ERROR: prioritizeSensor", e.message, null)
                        return@setMethodCallHandler
                    }
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }
}
