abstract class CustomException implements Exception {
  final String message;
  const CustomException([this.message = '']);
}

class NoLoyalUserException extends CustomException {
  const NoLoyalUserException(
      [String message =
          "Sorry, you do not have required points to place the order"])
      : super(message);
}

class NoProductAvailableException extends CustomException {
  const NoProductAvailableException(
      [String message = "Sorry, the product is not available at the moment"])
      : super(message);
}

class NoShipmentAvailableException extends CustomException {
  const NoShipmentAvailableException(
      [String message = "Sorry, we do not ship at this time"])
      : super(message);
}
