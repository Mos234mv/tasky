import 'package:flutter/material.dart';

import 'package:todoprof/core/constants/app_sizes.dart';
import 'package:todoprof/core/constants/storage_key.dart';

import 'package:todoprof/core/services/prefrence_manager.dart';
import 'package:todoprof/core/widgets/custom_svg_picture.dart';
import 'package:todoprof/core/widgets/custom_text_form_field.dart';

import 'package:todoprof/features/Navigation/main_screen.dart';

class Welcome extends StatelessWidget {
  Welcome({super.key});
  final TextEditingController controller = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _key,
              child: Column(
                children: [
                  SizedBox(height: AppSizes.ph16),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomSvgPicture(
                        path: 'assets/Images/Vector.svg',
                        withColor: false,
                        width: AppSizes.w16,
                        height: AppSizes.h16,
                      ),

                      SizedBox(width: AppSizes.pw16),
                      Text(
                        "Tasky",
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ],
                  ),
                  SizedBox(height: AppSizes.ph108),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Welcome To Tasky",
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      SizedBox(width: AppSizes.pw8),
                      CustomSvgPicture(
                        path:
                            'assets/Images/waving-hand-medium-light-skin-tone-svgrepo-com 1.svg',
                        withColor: false,
                      ),
                    ],
                  ),
                  SizedBox(height: AppSizes.ph8),
                  Text(
                    "Your productivity journey starts here.",
                    style: Theme.of(
                      context,
                    ).textTheme.displaySmall!.copyWith(fontSize: AppSizes.sp16),
                  ),
                  SizedBox(height: AppSizes.ph24),
                  CustomSvgPicture(
                    path: 'assets/Images/pana.svg',
                    withColor: false,
                    width: AppSizes.w215,
                    height: AppSizes.h204,
                  ),

                  SizedBox(height: AppSizes.ph60),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppSizes.pw16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextFormField(
                          controller: controller,
                          hintText: 'e.g. Sarah Khalid',
                          title: "Full Name",
                          validator: (String? value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'please enter your full name';
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: AppSizes.ph24),
                        ElevatedButton(
                          onPressed: () async {
                            if (_key.currentState?.validate() ?? false) {
                              PrefrenceManager().setString(
                                StorageKey.userName,
                                controller.value.text,
                              );

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return MainScreen();
                                  },
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('please enter your full name'),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Color(0xFFFFFCFC),
                            backgroundColor: Color(0xff15B86C),
                            fixedSize: Size(
                              MediaQuery.of(context).size.width,
                              AppSizes.h40,
                            ),
                          ),
                          child: Text(
                            'Let’s Get Started',
                            style: TextStyle(fontSize: AppSizes.sp16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
