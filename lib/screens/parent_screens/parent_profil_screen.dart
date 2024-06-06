import 'package:babysitter/blocs/parentauthbloc/auth_bloc.dart';
import 'package:babysitter/blocs/parentinfo/parentnfo_bloc.dart';
import 'package:babysitter/screens/select_account.screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ParentProfileScreen extends StatefulWidget {
  const ParentProfileScreen({super.key});

  @override
  State<ParentProfileScreen> createState() => _ParentProfileScreenState();
}

class _ParentProfileScreenState extends State<ParentProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
      ),
      body: Center(
        child: ListView(
          children: [
            MultiBlocListener(
              listeners: [
                BlocListener<AuthBloc, AuthState>(listener: (context, state) {
                  if (state is LogedOut) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SelectAccountScreen()));
                  }
                }),
              ],
              child: BlocBuilder<ParentnfoBloc, ParentnfoState>(
                  builder: (context, state) {
                if (state is ParentinfoLoaded) {
                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.width / 3,
                        width: MediaQuery.of(context).size.width / 3,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(60),
                          child: state.model.familleImagePath != ""
                              ? Image.network(
                                  state.model.familleImagePath!,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  'images/mom-icon-in-cartoon-style-vector-8655229.jpg'),
                        ),
                      ),
                      state.model.famillePhone != null
                          ? Text(state.model.famillePhone)
                          : Text(state.model.familleEmail),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Divider(
                          thickness: 1,
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Column(
                          children: [
                            _buildCard(Icons.person_2_rounded, "Edit Profile"),
                            _buildCard(Icons.settings, "Settings"),
                            _buildCard(Icons.badge, "Job Application"),
                            _buildCard(Icons.favorite, "Favorites"),
                            _buildCard(Icons.support, "Support"),
                            _buildCard(Icons.logout, "Log Out", onTap: () {
                              BlocProvider.of<AuthBloc>(context)
                                  .add(LogoutEvent());
                            }),
                          ],
                        ),
                      ),
                    ],
                  );
                } else {
                  return const SizedBox();
                }
              }),
            )
          ],
        ),
      ),
    );
  }
}

Widget _buildCard(IconData iconData, String text, {VoidCallback? onTap}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
    child: SizedBox(
      height: 90,
      child: Card(
        child: InkWell(
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    iconData,
                    size: 40,
                    color: Colors.purple,
                  ),
                  Text(text),
                ],
              ),
              const Icon(Icons.arrow_forward_ios),
            ],
          ),
        ),
      ),
    ),
  );
}
