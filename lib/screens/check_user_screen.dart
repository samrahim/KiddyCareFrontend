import 'package:babysitter/repositories/shared_pref_repositrory.dart';
import 'package:babysitter/screens/parent_screens/parent_init_layout.dart';
import 'package:babysitter/screens/select_account.screen.dart';
import 'package:babysitter/screens/sitter_screens.dart/sitter_init_layout.dart';
import 'package:flutter/material.dart';

class ChecKBefore extends StatefulWidget {
  const ChecKBefore({super.key});

  @override
  State<ChecKBefore> createState() => _ChecKBeforeState();
}

class _ChecKBeforeState extends State<ChecKBefore> {
  SharedRepo repo = SharedRepo();

  @override
  void initState() {
    super.initState();
    loadInfo();
  }

  void loadInfo() async {
    final mp = await repo.getInfo();

    if (mp == null && context.mounted) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const SelectAccountScreen()));
    } else if (mp != null && context.mounted) {
      if (mp['type'] == "Parent") {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => ParentInitLayout(
                      id: mp['id'],
                    )));
      } else if (mp['type'] == "Sitter") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SitterInitLayout(
              id: mp['id'],
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
