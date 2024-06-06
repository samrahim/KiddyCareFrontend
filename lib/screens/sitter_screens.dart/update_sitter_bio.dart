import 'package:babysitter/blocs/sitterauthbloc/sitterauthbloc_bloc.dart';
import 'package:babysitter/screens/sitter_screens.dart/pick_fronid.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateBio extends StatefulWidget {
  final int sitterId;

  const UpdateBio({super.key, required this.sitterId});

  @override
  State<UpdateBio> createState() => _UpdateBioState();
}

class _UpdateBioState extends State<UpdateBio> {
  TextEditingController controller = TextEditingController();

  String initval = 'Beginner';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height / 8),
              TextFormField(
                controller: controller,
                maxLines: 4,
                decoration: InputDecoration(
                    hintText: "Tell us about you ",
                    hintStyle: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w400),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(color: Colors.pink, width: 1.6),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(color: Colors.pink, width: 1.6),
                    )),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 20),
              const Text("how you rate your experience"),
              DropdownButtonFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.pink, width: 1.6),
                )),
                isExpanded: true,
                value: initval,
                onChanged: (newValue) {
                  setState(() {
                    initval = newValue!;
                  });
                },
                items: <String>['Beginner', 'Intermediate', 'Advanced']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<SitterauthblocBloc>(context).add(
                        UpdateSitterBioAndExperience(
                            sitterId: widget.sitterId,
                            experience: initval,
                            bio: controller.text));
                  },
                  child: const Text("Next")),
              BlocListener<SitterauthblocBloc, SitterauthblocState>(
                listener: (context, state) {
                  if (state is SitterLoginScreenLoaded) {
                    print("hello");
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const PickFrontIdCardImage()));
                  }
                },
                child: const SizedBox(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
