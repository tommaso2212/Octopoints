import 'package:flutter/material.dart';
import 'package:octopoints_flutter/ui/components/OctopointsProgressIndicator.dart';
import 'package:octopoints_flutter/ui/components/TextInputField.dart';

class FilterableList extends StatefulWidget {
  final Future<List> list;
  final bool Function(dynamic, String) filterListByText;
  final Widget Function(dynamic, BuildContext) elementToWidget;

  const FilterableList(this.list, this.filterListByText, this.elementToWidget);

  @override
  State<FilterableList> createState() => _FilterableListState();
}

class _FilterableListState extends State<FilterableList> {
  TextEditingController controller = TextEditingController(text: "");
  
  String textFilter = "";

  Future<List> getFilteredList(String textFilter) async {
    if(textFilter.isNotEmpty){
      return (await widget.list).where((element) => widget.filterListByText(element, controller.text)).toList();
    }
    return widget.list;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: TextInputField(
              controller: controller,
              label: "Search",
              onChanged: () => setState(() {
                textFilter = controller.text;
              }),
              autoFocus: false,
              validateInput: (_)=> true,),
        ),
        FutureBuilder(
          future: getFilteredList(textFilter),
          initialData: const <Widget>[],
          builder: (BuildContext context, AsyncSnapshot<List> snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return const OctopointsProgressIndicator();
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
