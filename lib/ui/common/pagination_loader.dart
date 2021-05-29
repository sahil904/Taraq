import 'package:flutter/material.dart';
import 'package:test/ui/common/common_widgets.dart';

class PaginationLoader extends StatelessWidget {
  final Stream<bool> stream;

  PaginationLoader({@required this.stream});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: stream,
      builder: (context, streamData) {
        print('Showing loader here ${streamData?.data}');
        return Visibility(
            visible: streamData.hasData && streamData.data,
            child: const HalfLoader(),
        );
      },
    );
  }
}
