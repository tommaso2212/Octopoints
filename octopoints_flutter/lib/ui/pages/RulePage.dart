import 'package:flutter/material.dart';
import 'package:octopoints_flutter/service/model/Rule.dart';
import 'package:octopoints_flutter/service/service.dart';
import 'package:octopoints_flutter/ui/components/CreateFAB.dart';
import 'package:octopoints_flutter/ui/components/OctopointsProgressIndicator.dart';
import 'package:octopoints_flutter/ui/components/RoundedCard.dart';
import 'package:octopoints_flutter/ui/components/modal/BaseModal.dart';
import 'package:octopoints_flutter/ui/components/modal/CreateRuleModal.dart';
import 'package:octopoints_flutter/ui/providers/RuleProvider.dart';
import 'package:octopoints_flutter/ui/theme/OctopointsTheme.dart';
import 'package:provider/provider.dart';

class RulePage extends StatelessWidget {
  final Match _match;
  late final RuleProvider _ruleProvider;

  RulePage(this._match) {
    _ruleProvider = RuleProvider(_match);
  }

  String? thenValueToString(Rule rule){
    switch(rule.thenArgument){
      case RuleThenArgumentEnum.endGame: return null;
      case RuleThenArgumentEnum.total: return rule.thenValue.toString();
      case RuleThenArgumentEnum.teamStatus: return TeamStatusEnum.values[rule.thenValue!].name;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop<Future<List<Rule>>>(context, _ruleProvider.data);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            _match.name,
          ),
        ),
        body: ChangeNotifierProvider.value(
          value: _ruleProvider,
          builder: (context, _) => FutureBuilder(
            future: context.select<RuleProvider, Future<List<Rule>>>(
                (provider) => provider.data),
            initialData: const <Rule>[],
            builder: (context, AsyncSnapshot<List<Rule>> snap) {
              if (snap.connectionState == ConnectionState.waiting) {
                return const OctopointsProgressIndicator();
              } else if (snap.hasError) {
                return Text("Errore" + snap.error.toString());
              } else {
                return ListView.builder(
                  itemCount: snap.data!.length,
                  itemBuilder: (context, index) {
                    Rule rule = snap.data![index];
                    return RoundedCard(
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              spacing: 20,
                              runSpacing: 10,
                              children: [
                                const Text(
                                  "Se:",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: OctopointsTheme.darkGrey,
                                  ),
                                  child: Text(
                                    rule.ifArgument.name,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: OctopointsTheme.darkGrey,
                                  ),
                                  child: Text(
                                    rule.ifCondition.name,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: OctopointsTheme.darkGrey,
                                  ),
                                  child: Text(
                                    rule.ifValue.toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              spacing: 20,
                              runSpacing: 10,
                              children: [
                                const Text(
                                  "Allora:",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: OctopointsTheme.darkGrey,
                                  ),
                                  child: Text(
                                    rule.thenArgument.name,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                thenValueToString(rule) != null ?
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: OctopointsTheme.darkGrey,
                                  ),
                                  child: Text(
                                    thenValueToString(rule)!,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                ) : const SizedBox.shrink(),
                              ],
                            ),
                          ),
                        ],
                      ),
                      onDelete: () =>
                          context.read<RuleProvider>().deleteRule(rule),
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
              value: _ruleProvider,
              child: CreateRuleModal(_match),
            ),
          ),
        ),
      ),
    );
  }
}
