import 'package:flutter/widgets.dart';
import 'package:localization/localization.dart';
import 'package:space_station/models/thread.dart';
import 'package:space_station/views/_share/thread_item.dart';

import '../../_share/titled_container.dart';

class HotestThreadList extends StatelessWidget {
  final List<Thread> threads;
  const HotestThreadList(this.threads, {Key? key, required}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TitledContainer(
      title: 'hit_topics'.i18n(),
      body: Column(
        children: List<ThreadItem>.generate(
          threads.length,
          (index) => ThreadItem(
            data: threads[index],
            onTap: (threadID) => print(threadID),
          ),
          growable: false,
        ),
      ),
    );
  }
}
