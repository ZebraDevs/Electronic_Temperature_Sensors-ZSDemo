import 'package:flutter/material.dart';

class IsLoadingView extends StatelessWidget {
  const IsLoadingView({required this.message, super.key});
  final String message;
  @override
  build(context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
          ),
          const CircularProgressIndicator(),
          const SizedBox(
            height: 32,
          ),
          Text(message),
        ],
      ),
    );
  }
}

class LoadingWidget extends StatelessWidget {
  final bool isLoading;
  final Widget child;

  const LoadingWidget({
    super.key,
    required this.isLoading,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Positioned(
            left: 0,
            top: 0,
            right: 0,
            bottom: 0,
            child: Container(
              color: Colors.white.withOpacity(0.6),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
      ],
    );
  }
}
