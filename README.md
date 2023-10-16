Public repository of Flutter source code for the ZSDemo mobile application for Android, which showcases the capabilities of Zebra’s ZS300 electronic temperature sensors, including the following:
- Create a task with a ZS300 sensor, set temperature limits and sampling interval.
- Get task data and alarms.
- Download task data to a CSV file to export out to a PC for later analysis.

## Google Play listing

- ZSDemo: https://play.google.com/store/apps/details?id=com.zebra.zsdemo

## Release Notes

- V1.0.823
  - Initial Release

## Prerequisites

When building this demo application, users must specify their API key during the build process. The API key is used to interact with the REST API and is used to authenticate with the ZSFinder service.

This software also requires the installation of the ZSFinder Android service.
- Google Play listing for ZSFinder: https://play.google.com/store/apps/details?id=com.zebra.zsfinder&hl=en_US

## Examples
Build parameter for API key argument: `--dart-define=AUTH=apikey`

## Requesting an API key

To request a developer API key, you will need a Developer Portal account with Zebra.

### To open a Developer Portal account

1.	Go to https://developer.zebra.com/
2.	Click Register and follow the prompts to open a developer account.

### To request a API key through Zebra Technologies

To request a key, please reach out to [ankan.basak@zebra.com](mailto:ankan.basak@zebra.com) providing your email address used above.

### To retrieve a key

1.	You will receive a Welcome letter from Zebra Technologies in your email (used for developer portal account) notifying you the key has been delivered.
2.	Login to developer portal account
3.	Go to My Account -> My Apps.
4.	Click on Electronic Temperature Sensors app. Under Credentials, the Consumer Key (API key) will be populated there.

**Note:** The developer key is only valid for 90 days and will expire after that. Please reach out to Zebra Technologies closer to 90days. The key is free of charge, and you get all the capabilities – Management, Data, Event APIs and the Android service (ZSFinder).

## Code of Conduct

Your safety is important to us, thus all contributions to and interactions with ZebraDevs projects have to adhere to our Code of Conduct. You can find the Code of Conduct [here](Code_of_Conduct.md).

## License

[Zebra End User License Agreement](ZEBRA_EULA_LICENSE.md).

## Additional Documentation

- Creating a ZS300 App - with API use examples:
https://developer.zebra.com/blog/cold-chain-tracking-zebra-electronic-temperature-sensors
- Zebra Developer Portal:
https://developer.zebra.com/apis/electronic-temperature-sensors#/
- Developer Guide:
https://docs.zebra.com/content/tcm/us/en/solutions/intelligent-sensors/zszb-dev-guide/management-and-data-reporting-for-electronic-tempe.html
- ZS300 Series Sensors Support:
https://www.zebra.com/us/en/support-downloads/environmental-sensors/electronic-temperature-sensors-data-device-monitoring-tools/zs300-sensors.html

