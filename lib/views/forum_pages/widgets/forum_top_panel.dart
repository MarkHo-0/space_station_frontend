import 'package:ez_localization/ez_localization.dart';
import 'package:flutter/material.dart';

class ForumTopPanel extends StatelessWidget {
  final void Function(int orderID) onOrderChanged;
  final void Function(String query) onSearch;
  final void Function() onGoToPostPage;

  const ForumTopPanel({
    super.key,
    required this.onOrderChanged,
    required this.onSearch,
    required this.onGoToPostPage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
      child: Row(
        children: [
          buildOrderButton(context),
          buildSearchBar(context),
          buildPostButtom(context),
        ],
      ),
    );
  }

  Widget buildOrderButton(BuildContext context) {
    bool isOrderByTime = true;
    return StatefulBuilder(builder: (BuildContext ctx, StateSetter setState) {
      return IconButton(
        onPressed: () {
          setState(() => isOrderByTime = !isOrderByTime);
          onOrderChanged(isOrderByTime ? 1 : 2);
        },
        icon: Icon(isOrderByTime ? Icons.timer_outlined : Icons.whatshot),
        tooltip: context.getString('thread_order_${isOrderByTime ? 1 : 2}'),
      );
    });
  }

  Widget buildSearchBar(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).splashColor,
            borderRadius: BorderRadius.circular(32),
          ),
          child: TextField(
            maxLength: 10,
            textAlign: TextAlign.center,
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              counterText: "",
              border: InputBorder.none,
              isDense: true,
              hintText: context.getString("forum_searchbar_hit_text"),
              focusedBorder: InputBorder.none,
            ),
            onSubmitted: (value) => onSearch(value),
          ),
        ),
      ),
    );
  }

  Widget buildPostButtom(BuildContext context) {
    return IconButton(
      onPressed: onGoToPostPage,
      icon: const Icon(Icons.edit),
      color: Theme.of(context).primaryColor,
      tooltip: context.getString('post_thread_tooltip'),
    );
  }
}
