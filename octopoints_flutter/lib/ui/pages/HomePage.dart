import 'package:flutter/material.dart';
import 'package:octopoints_flutter/service/model/Match.dart';
import 'package:octopoints_flutter/ui/components/RoundedCard.dart';
import 'package:octopoints_flutter/ui/components/modal/CreateMatchModal.dart';
import 'package:octopoints_flutter/ui/pages/BasePage.dart';
import 'package:octopoints_flutter/ui/providers/MatchProvider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MatchProvider(),
      builder: (context, child) => BasePage(
        appBar: AppBar(
          title: const Text(
            'Octopoints',
          ),
          actions: [
            IconButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Container(),
                ),
              ),
              icon: const Icon(
                Icons.supervised_user_circle,
                size: 35,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: FutureBuilder(
            future: context.select<MatchProvider, Future<List<Widget>>>(
              (value) async {
                List<Match> matches = await value.getList();
                return matches
                    .map((e) => RoundedCard(
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                            ),
                            alignment: AlignmentDirectional.topStart,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: Text(
                                e.description,
                                style: const TextStyle(
                                  fontSize: 24,
                                ),
                              ),
                            ),
                          ),
                        ))
                    .toList();
              },
            ),
            initialData: const <Widget>[],
            builder: (_, AsyncSnapshot<List<Widget>> snapshot) => Column(
              children: snapshot.data!,
            ),
          ),
        ),
        createModal: CreateMatchModal(context),
      ),
    );
  }
}
