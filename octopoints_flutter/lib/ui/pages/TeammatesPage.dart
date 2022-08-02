import 'package:flutter/material.dart';
import 'package:octopoints_flutter/service/service.dart';
import 'package:octopoints_flutter/ui/common_widget/create_floating_action_button.dart';
import 'package:octopoints_flutter/ui/common_widget/octopoints_progress_indicator.dart';
import 'package:octopoints_flutter/ui/common_widget/rounded_card.dart';
import 'package:octopoints_flutter/ui/components/modal/AddTeammatesModal.dart';
import 'package:octopoints_flutter/ui/modal/base_modal.dart';
import 'package:octopoints_flutter/ui/providers/TeammatesProvider.dart';
import 'package:provider/provider.dart';

class TeammatesPage extends StatelessWidget {
  final Team _team;
  late final TeammatesProvider _teammatesProvider;

  TeammatesPage(this._team) {
    _teammatesProvider = TeammatesProvider(_team);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop<List<User>>(context, _teammatesProvider.data);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(),
        body: ChangeNotifierProvider.value(
          value: _teammatesProvider,
          builder: (context, _) => FutureBuilder(
            future: context.select<TeammatesProvider, Future<List<User>>>(
                (provider) => Future.value(provider.data)),
            initialData: const <User>[],
            builder: (context, AsyncSnapshot<List<User>> snap) {
              if (snap.connectionState == ConnectionState.waiting) {
                return OctopointsProgressIndicator();
              } else if (snap.hasError) {
                return Text("Errore" + snap.error.toString());
              } else {
                return ListView.builder(
                  itemCount: snap.data!.length,
                  itemBuilder: (context, index) {
                    User user = snap.data![index];
                    return RoundedCard(
                      child: Text(
                        user.username,
                        overflow: TextOverflow.clip,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onDelete: () =>
                          context.read<TeammatesProvider>().leaveTeam(user),
                    );
                  },
                );
              }
            },
          ),
        ),
        floatingActionButton: CreateFloatingActionButton(
          onPressed: () => BaseModal.showModal(
            context,
            ChangeNotifierProvider.value(
              value: _teammatesProvider,
              child: AddTeammatesModal(_team),
            ),
          ),
        ),
      ),
    );
  }
}
