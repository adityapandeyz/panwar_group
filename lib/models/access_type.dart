enum UserType { admin, viewer, logger, none }

class UserAccess {
  UserType userType;

  UserAccess({
    required this.userType,
  });
}
