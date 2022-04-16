import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:octopoints_flutter/service/model/Match.dart';
import 'package:octopoints_flutter/ui/components/CreateFAB.dart';
import 'package:octopoints_flutter/ui/components/OctopointsProgressIndicator.dart';
import 'package:octopoints_flutter/ui/components/RoundedCard.dart';
import 'package:octopoints_flutter/ui/components/modal/BaseModal.dart';
import 'package:octopoints_flutter/ui/components/modal/CreateMatchModal.dart';
import 'package:octopoints_flutter/ui/pages/RulePage.dart';
import 'package:octopoints_flutter/ui/pages/TeamPage.dart';
import 'package:octopoints_flutter/ui/pages/UserPage.dart';
import 'package:octopoints_flutter/ui/providers/MatchProvider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final MatchProvider _matchProvider = MatchProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Octopoints',
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UserPage(), //user page
              ),
            ),
            icon: const Icon(
              Icons.supervised_user_circle,
              size: 35,
            ),
          ),
        ],
      ),
      body: ChangeNotifierProvider.value(
        value: _matchProvider,
        builder: (context, _) => FutureBuilder(
          future: context.select<MatchProvider, Future<List<Match>>>(
              (provider) => provider.data),
          initialData: const <Match>[],
          builder: (context, AsyncSnapshot<List<Match>> snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return const OctopointsProgressIndicator();
            } else if (snap.hasError) {
              return Text("Errore" + snap.error.toString());
            } else {
              return ListView.builder(
                itemCount: snap.data!.length,
                itemBuilder: (context, index) {
                  Match match = snap.data![index];
                  return RoundedCard(
                    Container(
                      margin: const EdgeInsets.only(right: 40),
                      child: Text(
                        match.name,
                        overflow: TextOverflow.clip,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TeamPage(match), //user page
                      ),
                    ),
                    onDelete: (() => _matchProvider.deleteMatch(match)),
                    onLongPress: () async {
                      match.rules = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RulePage(match), //user page
                        ),
                      );
                    },
                  );
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: CreateFAB(
        onPressed: () => BaseModal.showModal(
          context,
          ChangeNotifierProvider.value(
            value: _matchProvider,
            child: CreateMatchModal(),
          ),
        ),
      ),
    );
  }
}
