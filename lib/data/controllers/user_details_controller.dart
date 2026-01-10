import 'package:tasky/core/imports.dart';

class UserDetailsController extends ChangeNotifier {
  late String _name;
  late String _quote;
  String? _image;
  bool _isLoading = true;

  String get name => _name;
  String get quote => _quote;
  String? get image => _image;
  bool get isLoading => _isLoading;

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
    _quote = fetchedQuote;
    _image = fetchedImage;
    _isLoading = false;
    notifyListeners();
  }
}
