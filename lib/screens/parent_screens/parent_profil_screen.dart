import 'package:babysitter/blocs/parentinfo/parentnfo_bloc.dart';
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
            BlocBuilder<ParentnfoBloc, ParentnfoState>(
                builder: (context, state) {
              if (state is ParentinfoLoaded) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      color: Colors.red,
                      height: MediaQuery.of(context).size.width / 3,
                      width: MediaQuery.of(context).size.width / 3,
                      child: state.model.familleImagePath != ""
                          ? Image.network(state.model.familleImagePath!)
                          : Image.asset(
                              'images/mom-icon-in-cartoon-style-vector-8655229.jpg'),
                    ),
                    state.model.famillePhone != null
                        ? Text(state.model.famillePhone)
                        : Text(state.model.familleEmail)
                  ],
                );
              } else {
                return const SizedBox();
              }
            }),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Divider(
                thickness: 1,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Card(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.person_2_rounded,
                          size: 40,
                          color: Colors.purple,
                        ),
                        Text("Edit Profile")
                      ],
                    ),
                    SizedBox(
                      width: 80,
                      height: 60,
                    ),
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Card(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.settings,
                          size: 40,
                          color: Colors.purple,
                        ),
                        Text("Settings")
                      ],
                    ),
                    SizedBox(
                      width: 80,
                      height: 60,
                    ),
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Card(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.badge,
                          size: 40,
                          color: Colors.purple,
                        ),
                        Text("Job Application")
                      ],
                    ),
                    SizedBox(
                      width: 80,
                      height: 60,
                    ),
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Card(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.favorite,
                          size: 40,
                          color: Colors.purple,
                        ),
                        Text("Favorites")
                      ],
                    ),
                    SizedBox(
                      width: 80,
                      height: 60,
                    ),
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Card(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.support,
                          size: 40,
                          color: Colors.purple,
                        ),
                        Text("Support")
                      ],
                    ),
                    SizedBox(
                      width: 80,
                      height: 60,
                    ),
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Card(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.logout,
                          size: 40,
                          color: Colors.purple,
                        ),
                        Text("Log Out")
                      ],
                    ),
                    SizedBox(
                      width: 80,
                      height: 60,
                    ),
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
