import 'package:flutter/material.dart';
import 'package:octopoints_flutter/ui/common_widget/text_input_field.dart';

class FilterableList extends StatefulWidget {
  final Widget Function(BuildContext context, int index, String textFilter)
      itemBuilder;
  final GlobalKey<AnimatedListState> listKey;
  final int initialItemCount;
  const FilterableList({
    Key? key,
    required this.itemBuilder,
    required this.listKey,
    required this.initialItemCount,
  }) : super(key: key);

  @override
  State<FilterableList> createState() => _FilterableListState();
}

class _FilterableListState extends State<FilterableList> {
  String textFilter = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: TextInputField(
            initialValue: textFilter,
            label: "Search",
            onChanged: (value) => setState(() {
              textFilter = value;
            }),
            autoFocus: false,
            validateInput: (_) => true,
          ),
        ),
        Expanded(
          child: AnimatedList(
            key: widget.listKey,
            initialItemCount: widget.initialItemCount,
            itemBuilder: (context, index, animation) => Builder(
              builder: (context) =>
                  widget.itemBuilder(context, index, textFilter),
            ),
          ),
        ),
      ],
    );
  }
}
