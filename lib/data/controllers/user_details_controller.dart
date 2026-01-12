import 'package:tasky/core/imports.dart';

class UserDetailsController extends ChangeNotifier {
  late String _name;
  late String _quote;
  String? _image;
  bool _isLoading = true;
  final TextEditingController _usernameC = TextEditingController();
  final TextEditingController _quoteC = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String get name => _name;
  String get quote => _quote;
  String? get image => _image;
  bool get isLoading => _isLoading;
  TextEditingController get usernameC => _usernameC;
  TextEditingController get quoteC => _quoteC;
  GlobalKey<FormState> get formKey => _formKey;

  @override
  void dispose() {
    super.dispose();
    _usernameC.dispose();
    _quoteC.dispose();
  }

  UserDetailsController() {
    init();
  }

  void init() {
    loadUserDetails();
  }

  Future<void> loadUserDetails() async {
    String fetchedName = await PrefHelper.getName() ?? "";
    String fetchedQuote =
        await PrefHelper.getQuote() ?? "One task at a time. One step closer.";
    String? fetchedImage = await PrefHelper.getProfileImage();

    _name = fetchedName;
    _usernameC.text = name;
    _quote = fetchedQuote;
    _quoteC.text = _quote;
    _image = fetchedImage;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> pickImage(BuildContext context, ImageSource source) async {
    final ThemeData theme = Theme.of(context);
    try {
      final XFile? pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage == null) return;
      final appDir = await getApplicationDocumentsDirectory();
      final newFile = await File(
        pickedImage.path,
      ).copy("${appDir.path}/${pickedImage.name}");
      await PrefHelper.saveProfileImage(newFile.path);
      if (!context.mounted) return;
      Dialogs.showSnackBar(
        message: "Image Changed Successfully.",
        backgroundColor: theme.primaryColor,
        context: context,
      );
      _image = newFile.path;
      notifyListeners();
    } catch (e) {
      if (!context.mounted) return;
      Dialogs.showSnackBar(
        message: "Faild to change Image!\nPlease try again.",
        backgroundColor: theme.colorScheme.error,
        context: context,
      );
    }
  }

  Future<void> clearProfileImage(BuildContext context) async {
    final ThemeData theme = Theme.of(context);
    await PrefHelper.clearProfileImage();
    if (!context.mounted) return;
    Dialogs.showSnackBar(
      message: "Image Deleted Successfully.",
      backgroundColor: theme.primaryColor,
      context: context,
    );
    _image = null;
    notifyListeners();
  }

  Future<void> selectImageActions(BuildContext context) async {
    final ImageActionsEnum? result = await Dialogs.showImageSourceDialog(
      context: context,
      controller: this,
    );
    if (!context.mounted) return;
    switch (result) {
      case ImageActionsEnum.gallery:
        await pickImage(context, ImageSource.gallery);
        break;

      case ImageActionsEnum.camera:
        await pickImage(context, ImageSource.camera);
        break;

      case ImageActionsEnum.delete:
        await clearProfileImage(context);
        break;

      default:
        break;
    }
  }

  Future<void> changeUserDetailes(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;
    final navigator = Navigator.of(context);
    _name = _usernameC.text.trim();
    _quote = _quoteC.text.trim().isEmpty || _quoteC.text == ""
        ? "One task at a time. One step closer."
        : _quoteC.text.trim();
    notifyListeners();
    await PrefHelper.saveName(_usernameC.text.trim());
    await PrefHelper.saveQuote(
      _quoteC.text.trim().isEmpty || _quoteC.text == ""
          ? "One task at a time. One step closer."
          : _quoteC.text.trim(),
    );
    navigator.pop();
  }
}
