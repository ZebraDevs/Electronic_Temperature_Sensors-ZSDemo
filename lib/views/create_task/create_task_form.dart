part of 'create_task_view.dart';

class CreateTaskForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final ScrollController controller;
  const CreateTaskForm({Key? key, required this.formKey, required this.controller}) : super(key: key);

  @override
  State<CreateTaskForm> createState() => _CreateTaskFormState();
}

class _CreateTaskFormState extends State<CreateTaskForm> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final state = context.watch<CreateTaskState>();

    return Form(
      key: widget.formKey,
      onChanged: () {
        state.isValid = !alarmsNotSet(state.alarmLowTemp, state.alarmHighTemp) && (widget.formKey.currentState?.validate() ?? false);
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            ZSCreateTaskSectionWidget(
              title: Text(
                Loco.current.createTaskLblName,
                style: Theme.of(context).textTheme.title1?.copyWith(fontSize: 20),
              ),
              content: [
                ZSTextFormField.name(
                  initialValue: state.name,
                  isMandatory: true,
                  enabled: false,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  maxLength: 64,
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            ZSCreateTaskSectionWidget(
              title: Text(
                Loco.current.createTaskHdlSensorConfiguration,
                style: Theme.of(context).textTheme.title1?.copyWith(fontSize: 20),
              ),
              subTitle: Text(Loco.current.createTaskHntSensorConfiguration),
            ),
            const SizedBox(
              height: 8,
            ),
            ZSCreateTaskSectionWidget(
              title: Text(Loco.current.createTaskLblReadingInterval),
              subTitle: Text(Loco.current.createTaskHntReadingInterval),
            ),
            ZSInputNumberStepperFormField(
              label: Loco.current.minutes,
              value: state.readingIntervalMinutes.replaceAll(RegExp(r'^0+(?=.)'), ''),
              onChanged: (String value) {
                state.changeReadingIntervalMinutes(value);
              },
              onUserNotAbleToTypeValidator: (value) => null,
              onlyInt: true,
              allowNegative: false,
              isMinutes: true,
              canGoDown: (_) {
                return state.readingIntervalMinutes != '0';
              },
              canGoUp: (_) {
                if (state.readingIntervalMinutes.isNotEmpty) {
                  return int.parse(state.readingIntervalMinutes) < 240;
                }
                return true;
              },
            ),
            ZSInputNumberStepperFormField(
              label: Loco.current.seconds,
              value: state.readingIntervalSeconds,
              onChanged: (String value) {
                state.changeReadingIntervalSeconds(value);
              },
              onUserNotAbleToTypeValidator: (String? value) => null,
              onlyInt: true,
              allowNegative: false,
              isSeconds: true,
              canType: state.readingIntervalMinutes != '240',
              canGoDown: (_) {
                if (state.readingIntervalMinutes == '0') {
                  return int.parse(state.readingIntervalSeconds) > 15;
                }
                if (state.readingIntervalMinutes == '') {
                  return false;
                }
                return state.readingIntervalSeconds != '0';
              },
              canGoUp: (_) {
                if (state.readingIntervalSeconds.isNotEmpty) {
                  if (state.readingIntervalMinutes == '240') {
                    return false;
                  }
                  return int.parse(state.readingIntervalSeconds) < 59;
                }
                return false;
              },
            ),
            ZSCreateTaskSectionWidget(
              title: Text(Loco.current.createTaskLblStartMode),
              subTitle: Text(Loco.current.createTaskHntStartMode),
              content: [
                Column(
                  children: selectedModes.keys.map(
                    (value) {
                      return RadioListTile<StartMode>(
                        value: value,
                        groupValue: state.startMode,
                        title: Text(value.toModeString()),
                        onChanged: (value) {
                          state.startMode = value!;
                          // this is the default option
                          state.tempBelow = '0';
                        },
                      );
                    },
                  ).toList(),
                )
              ],
            ),
            if (state.startMode == StartMode.delayed)
              ...[
                ZSCreateTaskSectionWidget(
                  title: Text(Loco.current.createTaskLblStartModeDelay),
                  subTitle: Text(Loco.current.createTaskHntStartModeDelay),
                  content: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ZSRadioListTileStepper<DelayedOption>(
                          value: DelayedOption.tempBelow,
                          groupValue: state.delayedOption,
                          label: Loco.current.createTaskItmTempBelow,
                          onChanged: (DelayedOption? dOption) {
                            if (dOption == null) return;
                            state.delayedOption = dOption;
                            // when you select this option, init to 0
                            state.tempBelow = '0';
                            state.tempAbove = '';
                            state.delayTimeToStart = '';
                            state.delayedUntil = null;
                            state.delayedUntilError = '';
                          },
                          child: ZSInputNumberStepperFormField(
                            value: state.tempBelow,
                            canType: state.delayedOption == DelayedOption.tempBelow,
                            onChanged: (String value) {
                              state.tempBelow = value;
                            },
                            validator: (value) {
                              // lowLimitsAreValid checks for -40 < x < 84
                              return isANumber(value) ?? lowLimitsAreValid(value);
                            },
                            // always valid
                            onUserNotAbleToTypeValidator: (value) => null,
                            onlyInt: true,
                            signed: true,
                          ),
                        ),
                        const SizedBox(height: 32),
                        ZSRadioListTileStepper<DelayedOption>(
                          value: DelayedOption.tempAbove,
                          groupValue: state.delayedOption,
                          label: Loco.current.createTaskItmTempAbove,
                          onChanged: (DelayedOption? dOption) {
                            if (dOption == null) return;
                            state.delayedOption = dOption;
                            // when you select this option, init to 0
                            state.tempBelow = '';
                            state.tempAbove = '0';
                            state.delayTimeToStart = '';
                            state.delayedUntil = null;
                            state.delayedUntilError = '';
                          },
                          child: ZSInputNumberStepperFormField(
                            value: state.tempAbove,
                            canType: state.delayedOption == DelayedOption.tempAbove,
                            onChanged: (String value) {
                              state.tempAbove = value;
                            },
                            validator: (value) {
                              // highLimitsAreValid checks for -39 < x < 85
                              return isANumber(value) ?? highLimitsAreValid(value);
                            },
                            // always valid
                            onUserNotAbleToTypeValidator: (value) => null,
                            onlyInt: true,
                            signed: true,
                          ),
                        ),
                        const SizedBox(height: 32),
                        ZSRadioListTileStepper<DelayedOption>(
                          value: DelayedOption.delayTime,
                          groupValue: state.delayedOption,
                          label: Loco.current.createTaskItmDelayTimeStart,
                          onChanged: (DelayedOption? dOption) {
                            if (dOption == null) return;
                            state.delayedOption = dOption;
                            // when you select this option, init to 1
                            state.tempBelow = '';
                            state.tempAbove = '';
                            state.delayTimeToStart = '1';
                            state.delayedUntil = null;
                            state.delayedUntilError = '';
                          },
                          child: ZSInputNumberStepperFormField(
                            value: state.delayTimeToStart,
                            canType: state.delayedOption == DelayedOption.delayTime,
                            onChanged: (String value) {
                              state.delayTimeToStart = value;
                            },
                            validator: (value) {
                              // delayTimeIsValid checks for 1 < x < 9999
                              return isANumber(value) ?? delayTimeIsValid(value, 240);
                            },
                            // always valid
                            onUserNotAbleToTypeValidator: (value) => null,
                            onlyInt: true,
                            canGoDown: (_) => state.delayTimeToStart != '1',
                          ),
                        ),
                        const SizedBox(height: 32),
                        ZSRadioListTileStepper<DelayedOption>(
                          value: DelayedOption.delayUntil,
                          groupValue: state.delayedOption,
                          label: Loco.current.createTaskItmDelayedUntil,
                          onChanged: (DelayedOption? dOption) {
                            if (dOption == null) return;
                            state.tempBelow = '';
                            state.tempAbove = '';
                            state.delayTimeToStart = '';
                            state.delayedOption = dOption;
                            state.delayedUntil = state.delayedUntil ?? DateTime.now().add(const Duration(minutes: 5)).toUtc();
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ZSDateSelector(
                                width: 240,
                                readonly: state.delayedOption != DelayedOption.delayUntil,
                                initialDate: state.delayedUntil ?? DateTime.now().add(const Duration(minutes: 5)).toUtc(),
                                onSelect: (date) => state.delayedUntil = date,
                                range: DateTimeRange(
                                  start: DateTime.now().add(const Duration(minutes: 5)),
                                  end: DateTime.now().add(
                                    const Duration(days: 30),
                                  ),
                                ),
                              ),
                              ErrorFieldWidget(state.delayedUntilError ?? ''),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ].divide(const SizedBox(height: 32)).toList(),
            ZSCreateTaskSectionWidget(
              title: Text(Loco.current.createTaskLblAlarmSettings),
              subTitle: Text(Loco.current.createTaskHntAlarmSettings),
              alert: alarmSettingAlarm(state),
              content: [
                Column(
                  children: [
                    ZSCheckboxStepper(
                      canType: true,
                      initValue: '5',
                      initialChecked: state.alarmLowTemp != null,
                      label: Loco.current.createTaskItmLowLimit,
                      onlyInt: true,
                      onChange: (String? value) {
                        state.alarmLowTemp = value;
                      },
                      value: state.alarmLowTemp,
                      validator: (lowLimit) {
                        final emptyError = isANumber(lowLimit);
                        final limitsError = alarmLimitsAreValid(lowLimit, state.alarmHighTemp);
                        final lowLimitsError = lowLimitsAreValid(lowLimit);
                        return emptyError ?? lowLimitsError ?? limitsError;
                      },
                      onUserNotAbleToTypeValidator: (emptyLow) {
                        final someLimitSet = someLimitIsSet(emptyLow, state.alarmHighTemp);
                        return someLimitSet;
                      },
                      canGoUp: (String value) {
                        return alarmLimitsAreValid(state.alarmLowTemp, state.alarmHighTemp) == null && lowLimitsAreValid(value) == null;
                      },
                      canGoDown: (String value) {
                        // so long as the low limits remain valid with this value
                        return lowLimitsAreValid(value) == null;
                      },
                    ),
                    ZSDoubleCheckboxStepper(
                      canCheck: state.lowLimitSet,
                      initialChecked: state.alarmDelayLowMinutes != null || state.alarmDelayLowSeconds != null,
                      label: Loco.current.createTaskItmLowDelay,
                      onChange: (value) {
                        state.alarmDelayLowMinutes = value?.minutes;
                        state.alarmDelayLowSeconds = value?.seconds;
                      },
                      value: DoubleValue<String>(
                        state.alarmDelayLowMinutes ?? '',
                        state.alarmDelayLowSeconds ?? '',
                      ),
                      onlyInt: true,
                      minutesLabel: Loco.current.minutes,
                      secondsLabel: Loco.current.seconds,
                    ),
                    ZSCheckboxStepper(
                      canType: true,
                      initValue: '35',
                      initialChecked: state.alarmHighTemp != null,
                      label: Loco.current.createTaskItmHighLimit,
                      onlyInt: true,
                      onChange: (String? value) {
                        state.alarmHighTemp = value;
                      },
                      value: state.alarmHighTemp,
                      validator: (highLimit) {
                        final emptyError = isANumber(highLimit);
                        final limitsError = alarmLimitsAreValid(state.alarmLowTemp, highLimit);
                        final highLimitsError = highLimitsAreValid(highLimit);
                        final someLimitSet = someLimitIsSet(state.alarmLowTemp, highLimit);
                        return emptyError ?? highLimitsError ?? limitsError ?? someLimitSet;
                      },
                      onUserNotAbleToTypeValidator: (emptyHigh) {
                        final someLimitSet = someLimitIsSet(state.alarmLowTemp, emptyHigh);
                        return someLimitSet;
                      },
                      canGoUp: (String value) {
                        // so long as the high limits remain valid with this value
                        return highLimitsAreValid(value) == null;
                      },
                      canGoDown: (String value) {
                        return alarmLimitsAreValid(state.alarmLowTemp, state.alarmHighTemp) == null && highLimitsAreValid(value) == null;
                      },
                    ),
                    ZSDoubleCheckboxStepper(
                      canCheck: state.highLimitSet,
                      initialChecked: state.alarmDelayHighMinutes != null || state.alarmDelayHighSeconds != null,
                      label: Loco.current.createTaskItmHighDelay,
                      onChange: (value) {
                        state.alarmDelayHighMinutes = value?.minutes;
                        state.alarmDelayHighSeconds = value?.seconds;
                      },
                      value: DoubleValue<String>(
                        state.alarmDelayHighMinutes ?? '',
                        state.alarmDelayHighSeconds ?? '',
                      ),
                      onlyInt: true,
                      minutesLabel: Loco.current.minutes,
                      secondsLabel: Loco.current.seconds,
                    ),
                    const SizedBox(height: 16),
                  ].divide(const SizedBox(height: 32)).toList(),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget? alarmSettingAlarm(CreateTaskState state) {
    if (alarmsNotSet(state.alarmLowTemp, state.alarmHighTemp)) {
      return Text(
        Loco.current.taskCreateAlarmNotSet,
        style: TextStyle(
          color: state.alarmIsEmpty ? ZSColors.error : ZSColors.warning,
        ),
      );
    }
    return const Text('');
  }

  String? isANumber(String? num) {
    if (num == null || num.isEmpty) return Loco.current.errorEmptyValue;
    final double? asDouble = double.tryParse(num);
    if (asDouble == null) {
      return Loco.current.errorEmptyNotANumber;
    }
    return null;
  }

  String? alarmLimitsAreValid(String? lowTemp, String? highTemp) {
    if (lowTemp == null || highTemp == null) return null;
    final double? low = double.tryParse(lowTemp);
    final double? high = double.tryParse(highTemp);
    if (low == null || high == null) {
      return null;
    }

    if (high <= low) {
      return Loco.current.taskCreateLowHigher;
    }
    if (low >= high) {
      return Loco.current.taskCreateHigher;
    }
    return null;
  }

  String? lowLimitsAreValid(String? lowTemp) {
    if (lowTemp == null) return null;
    final double? low = double.tryParse(lowTemp);
    if (low == null) {
      return null;
    }

    if (low < -40 || low > 84) {
      return Loco.current.taskCreateLowLimits;
    }
    return null;
  }

  String? highLimitsAreValid(String? highTemp) {
    if (highTemp == null) return null;
    final double? high = double.tryParse(highTemp);
    if (high == null) {
      return null;
    }

    if (high < -39 || high > 85) {
      return Loco.current.taskCreateHighLimits;
    }
    return null;
  }

  String? delayTimeIsValid(String? delayTimeMinutes, [int? maxValue]) {
    if (delayTimeMinutes == null) return null;
    final int? mins = int.tryParse(delayTimeMinutes);
    if (mins == null) {
      return null;
    }

    if (mins < 1 || mins > (maxValue ?? 1440)) {
      return Loco.current.taskCreateDelayMinutes;
    }
    return null;
  }

  String? someLimitIsSet(String? lowTemp, String? highTemp) {
    if (lowTemp == null) return null;
    if (highTemp == null) return null;
    if (lowTemp.isEmpty && highTemp.isEmpty) return Loco.current.taskCreateSetAlarm;
    final double? low = double.tryParse(lowTemp);
    final double? high = double.tryParse(highTemp);
    if (low != null || high != null) {
      // one was set
      return null;
    }
    // '' means error
    return Loco.current.taskCreateSetAlarm;
  }

  @override
  bool get wantKeepAlive => true;
}
