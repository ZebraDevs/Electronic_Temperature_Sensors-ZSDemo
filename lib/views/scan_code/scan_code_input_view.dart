import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zsdemo_app/common/utils/app_utils.dart';
import 'package:zsdemo_app/common/utils/utils.dart';
import 'package:zsdemo_app/components/input_fields/text_input_field.dart';
import 'package:zsdemo_app/generated/l10n.dart';
import 'package:zsdemo_app/models/scan_sensors.dart';
import 'package:zsdemo_app/states/sensor/scan_code_state.dart';
import 'package:provider/provider.dart';

class ScanCodeInputView extends StatelessWidget {
  final void Function(SensorSerialNumberData?) onSensorId;

  const ScanCodeInputView({super.key, required this.onSensorId});

  @override
  Widget build(BuildContext context) {
    final ScanCodeState state = context.watch<ScanCodeState>();
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 32, 16, 88),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            Loco.current.sensorID,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w400,
                ),
          ),
          const SizedBox(height: 4),
          ZSTextFormField(
            controller: state.sensorIdController,
            hint: Loco.current.addSensorEnterIdNumber,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'([A-Za-z0-9])')),
              UpperCaseTextFormatter(),
            ],
            keyboardType: TextInputType.text,
            onChanged: (String value) {
              state.sensorId = SensorSerialNumberData(serialNumber: value);
            },
            suffixIcon: IconButton(
              onPressed: () {
                state.sensorId = null;
                state.sensorIdController.clear();
              },
              icon: const Icon(Icons.close_rounded),
            ),
            onFieldSubmitted: (value) {
              if (value.isNotEmpty) {
                // hideKeyboard(context);
                state.sensorId = SensorSerialNumberData(serialNumber: value);
                onSensorId(state.sensorId!);
              }
            },
          ),
          const SizedBox(width: 20),
          ElevatedButton(
            onPressed: state.validateScanForm()
                ? () {
                    hideKeyboard(context);
                    state.sensorId != null ? onSensorId(state.sensorId!) : null;
                  }
                : null,
            child: Text(Loco.of(context).continueLabel),
          ),
        ],
      ),
    );
  }
}
