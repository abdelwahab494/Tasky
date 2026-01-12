import 'package:tasky/core/imports.dart';

class UserDetailsScreen extends StatelessWidget {
  const UserDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Consumer<UserDetailsController>(
        builder: (context, controller, child) {
          return Scaffold(
            appBar: AppBar(title: const Text("User Details")),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Form(
                      key: controller.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextField(
                            title: "User Name",
                            controller: controller.usernameC,
                            validationMessage: "Please Enter Your Name.",
                            hintText: "e.g. Abdelwahab Mo.",
                          ),
                          const Gap(20),
                          CustomTextField(
                            title: "Motivation Quote",
                            controller: controller.quoteC,
                            validationMessage: '',
                            maxLines: 5,
                            hintText:
                                "e.g. One task at a time. One step closer.",
                            validate: false,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: CustomElevatedButton(
              onPressed: () => controller.changeUserDetailes(context),
              title: "Save Changes",
              icon: Icons.check_rounded,
            ),
          );
        },
      ),
    );
  }
}
