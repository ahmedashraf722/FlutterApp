import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveIndicator extends StatefulWidget {
  final String os;

  const AdaptiveIndicator({
    Key? key,
    required this.os,
  }) : super(key: key);

  @override
  _AdaptiveIndicatorState createState() => _AdaptiveIndicatorState();
}

class _AdaptiveIndicatorState extends State<AdaptiveIndicator> {
  @override
  Widget build(BuildContext context) {
    if (widget.os == 'ios') {
      return const Center(child: CupertinoActivityIndicator());
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }
}
