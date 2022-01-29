import 'package:flutter/material.dart';
import 'package:octopoints/provider/provider.dart';
import 'package:octopoints/view/widget/widget.dart';

abstract class BasePage<T> extends StatelessWidget {
  Future<List<Widget>> getAll(BuildContext context) =>
      context.select<IProvider<T>, Future<List<Widget>>>(
        (provider) => provider.getAll().then(
              (list) => list
                  .map(
                    (e) => buildCard(context, e),
                  )
                  .toList(),
            ),
      );
  IProvider<T> get provider {
    return IProvider<T>();
  }

  AppBar appBar(BuildContext context);
  Widget buildCard(BuildContext context, T item);
  Widget body(BuildContext context, List<Widget>? children) => Column(
        children: children == null ? [] : children,
      );
  Widget modalBottomSheet(BuildContext context);

  Future<void> showModal(BuildContext buildContext) => showModalBottomSheet(
        context: buildContext,
        builder: (context) => Container(
          padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
          child: modalBottomSheet(buildContext),
        ),
        isScrollControlled: true,
        backgroundColor: OctopointsTheme.lightGrey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      );

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => provider,
        builder: (context, _) => Scaffold(
          appBar: appBar(context),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: FutureBuilder(
              future: getAll(context),
              initialData: <Widget>[],
              builder: (_, AsyncSnapshot<List<Widget>> snapshot) =>
                  body(context, snapshot.data),
            ),
          ),
          floatingActionButton: CommonFAB(
            onPressed: () => showModal(context),
          ),
        ),
      );
}
