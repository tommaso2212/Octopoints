import 'package:flutter/material.dart';
import 'package:octopoints_flutter/ui/components/OctopointsProgressIndicator.dart';
import 'package:octopoints_flutter/ui/components/TextInputField.dart';

class FilterableList extends StatefulWidget {
  final Future<List> list;
  final bool Function(dynamic, String)? filterListByText;
  final Widget Function(dynamic, BuildContext) elementToWidget;

  const FilterableList({required this.list, this.filterListByText, required this.elementToWidget});

  @override
  State<FilterableList> createState() => _FilterableListState();
}

class _FilterableListState extends State<FilterableList> {
  
  String textFilter = "";

  Future<List> getFilteredList(String textFilter) async {
    if(widget.filterListByText != null && textFilter.isNotEmpty){
      return (await widget.list).where((element) => widget.filterListByText!(element, textFilter)).toList();
    }
    return widget.list;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.filterListByText != null ?
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: TextInputField(
              initialValue: "",
              label: "Search",
              onChanged: (value) => setState(() {
                textFilter = value;
              }),
              autoFocus: false,
              validateInput: (_)=> true,),
        ): const SizedBox.shrink(),
        FutureBuilder(
          future: getFilteredList(textFilter),
          initialData: const <Widget>[],
          builder: (BuildContext context, AsyncSnapshot<List> snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return OctopointsProgressIndicator();
            } else if (snap.hasError) {
              return Text("Errore" + snap.error.toString());
            } else {
              return Expanded(
                child: ListView.builder(
                  itemCount: snap.data!.length,
                  itemBuilder: (context, index) => widget.elementToWidget(snap.data![index], context),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
