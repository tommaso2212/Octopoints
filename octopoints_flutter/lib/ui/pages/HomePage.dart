import 'package:flutter/material.dart';
import 'package:octopoints_flutter/service/model/Match.dart';
import 'package:octopoints_flutter/ui/components/OctopointsProgressIndicator.dart';
import 'package:octopoints_flutter/ui/components/RoundedCard.dart';
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
                builder: (context) => Container(), //user page
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
          initialData: [Match(name: "Prova")],
          builder: (context, AsyncSnapshot<List<Match>> snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return const OctopointsProgressIndicator();
            } else if (snap.hasError) {
              return Text("Errore");
            } else {
              return ListView.builder(
                itemBuilder: (context, index) => RoundedCard(
                  Text(snap.data![index].name),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
