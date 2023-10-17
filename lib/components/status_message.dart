import 'package:flutter/material.dart';
import 'package:zsdemo_app/common/styles/colors.dart';

class StatusMessage extends StatelessWidget {
  final String title;
  final String? description;
  final Widget? dismissButton;
  final Widget? confirmButton;
  final Widget? icon;

  const StatusMessage({
    super.key,
    required this.title,
    this.description,
    this.dismissButton,
    this.confirmButton,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 50, 24, 0),
      child: Column(
        children: [
          if (icon != null)
            IconTheme(
              data: const IconThemeData(size: 36),
              child: icon!,
            ),
          const SizedBox(
            height: 8,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 32),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 32,
          ),
          if (description != null)
            Text(
              description!,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          const SizedBox(
            height: 36,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (dismissButton != null) dismissButton!,
              if (confirmButton != null) confirmButton!,
            ],
          ),
        ],
      ),
    );
  }
}

class LoadingStatus extends StatelessWidget {
  final String label;
  final String? description;
  const LoadingStatus({super.key, this.label = '', this.description});

  @override
  Widget build(BuildContext context) {
    return StatusMessage(
      key: key,
      icon: const SizedBox(
        width: 80,
        height: 80,
        child: CircularProgressIndicator(
          backgroundColor: ZSColors.neutralLight100,
        ),
      ),
      title: label,
      description: description,
    );
  }
}
