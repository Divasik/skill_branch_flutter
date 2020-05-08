import '../string_util.dart';

enum LoginType { email, phone }

class User {
  String email;
  String phone;

  String _lastName;
  String _firstName;

  LoginType _type;

  List<User> friends = [];

  User._({String firstName, String lastName, String phone, String email})
      : _firstName = firstName,
        _lastName = lastName,
        this.phone = phone,
        this.email = email {
    print("User is created");
    _type = email != null ? LoginType.email : LoginType.phone;
  }

  factory User({String name, String phone, String email}) {
    if (name.isEmpty) throw Exception("User name is empty");
    if (phone != null && phone.isEmpty || email != null && email.isEmpty) throw Exception(
        "phone or email is empty"
    );

    return User._(
        firstName: _getFirstName(name),
        lastName: _getLastName(name),
        phone: phone != null ? checkPhone(phone) : null,
        email: email != null ? checkEmail(email) : null
    );
  }

  String get login {
    return _type == LoginType.phone ? phone : email;
  }

  String get name {
    return "${_firstName.capitalize()} ${_lastName.capitalize()}";
  }


  @override
  bool operator ==(other) {
    if (other == null) {
      return false;
    }

    if (other is User) {
      return _firstName == other._firstName && _lastName == other._lastName &&
          (phone == other.phone || email == other.email);
    }
  }

  void addFriends(Iterable<User> newFriends) {
    friends.addAll(newFriends);
  }

  void removeFriend(User friend) {
    friends.remove(friend);
  }

  String get userInfo => '''
    name: $name
    email: $email
    firstName: $_firstName
    lastName: $_lastName
    friends: ${friends.toList()}
  ''';


  @override
  String toString() {
    return '''
    name: $name
    email: $email
    friends: ${friends.toList()}
  ''';
  }

  static String _getLastName(String userName) => userName.split(" ")[1];

  static String _getFirstName(String userName) => userName.split(" ")[0];

  static String checkPhone(String phone) {
    String pattern = r"^(?:[+])?[0-9]{11}";
    phone = phone.replaceAll(RegExp("[^+\\d]"), "");

    if (phone == null || phone.isEmpty) {
      throw Exception("Enter don't empty phone number");
    } else if (!RegExp(pattern).hasMatch(phone)) {
      throw Exception(
          "Enter a valid phone number starting with a + and containing 11 digits");
    }

    return phone;
  }

  static String checkEmail(String email) {
    if (email == null || email.isEmpty) {
      throw Exception("Enter not empty email");
    }
    if(!email.contains("@")) {
      throw Exception("Email is not valid registerUserByPhone");
    }

    return email;
  }
}

mixin UserUtils {
  String capitalize(String s) {
    return s.capitalize();
  }
}