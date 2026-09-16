import 'package:flutter/material.dart';
import 'package:todoprof/core/constants/app_sizes.dart';
import 'package:todoprof/core/constants/storage_key.dart';
import 'package:todoprof/core/services/prefrence_manager.dart';
import 'package:todoprof/core/widgets/custom_text_form_field.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({
    super.key,
    required this.userName,
    required this.motivationQuote,
  });
  final String userName;
  final String? motivationQuote;

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  late final TextEditingController userNameController;

  late final TextEditingController motivationQuoteController;

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    userNameController = TextEditingController(text: widget.userName);
    motivationQuoteController = TextEditingController(
      text: widget.motivationQuote,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("User Details")),
      body: Padding(
        padding: EdgeInsets.all(AppSizes.pw16),
        child: Form(
          key: _key,
          child: Column(
            children: [
              CustomTextFormField(
                controller: userNameController,
                hintText: "Mostafa",
                title: "User Name",
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Enter UserName";
                  }
                  return null;
                },
              ),
              SizedBox(height: AppSizes.ph20),
              CustomTextFormField(
                controller: motivationQuoteController,
                hintText: "One task at a time. One step closer.",
                title: "Motivation Quote",
                maxlines: 5,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Motivation Quote";
                  }
                  return null;
                },
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () async {
                  if (_key.currentState!.validate()) {
                    PrefrenceManager().setString(
                      StorageKey.userName,
                      userNameController.value.text,
                    );
                    await PrefrenceManager().setString(
                      StorageKey.motivationQuote,
                      motivationQuoteController.value.text,
                    );

                    Navigator.pop(context, true);
                  } else {
                    //SnackBar
                  }
                },

                child: Text("Save Changes"),
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(
                    MediaQuery.of(context).size.width,
                    AppSizes.h40,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
