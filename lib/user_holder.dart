import 'models/user.dart';

class UserHolder {
  Map<String, User> users = {};

  void registerUser(String name, String phone, String email){
    User user = User(name: name, phone: phone, email: email);

    if(!users.containsKey(user.login)) {
      users[user.login] = user;
    } else {
      throw Exception("User with this name already exist");
    }
  }

  User getUserByLogin(String login) {
    return users[login];
  }

  List<User> importUsers(List<String> strUsers) {
    List<User> users = [];
    strUsers.forEach((str) {
      List<String> tokens = str.trim().split("\n");
      tokens = tokens.map((s) => s.trim().replaceAll(";", "")).toList();
      User u = User(name: tokens[0].trim(), email: tokens[1].trim(), phone: tokens[2].trim());
      users.add(u);
    });
    return users;
  }

  void setFriends(String login, List<User> friends) {
    User user = getUserByLogin(login);
    if(user != null) {
      user.friends = friends;
    }
  }

  User registerUserByEmail(String fullName, String email) {
    User user = User(name: fullName, email: email);

    if(!users.containsKey(user.login)) {
      users[user.login] = user;
    } else {
      throw Exception('Email is not valid registerUserByPhone');
    }

    return user;
  }

  User registerUserByPhone(String fullName, String phone) {
    User user = User(name: fullName, phone: phone);

    users.forEach((_, value) {
      if(value.phone == user.phone) {
        throw Exception('A user with this phone already exists');
      }
    });

    if(!users.containsKey(user.login)) {
      users[user.login] = user;
    }

    return user;
  }

  User findUserInFriends(String fullName, User user) {
    User targetUser = users[fullName];

    if(targetUser == null) {
      throw Exception("User $fullName not registered");
    }

    User friend = targetUser.friends.firstWhere(
            (u) => u == user,
        orElse: () => throw Exception("${user.login} is not a friend of the login")
    );

    return friend;
  }
}