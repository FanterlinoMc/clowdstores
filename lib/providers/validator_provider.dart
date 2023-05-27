import 'package:flutter/foundation.dart';

class ValidatorProvider with ChangeNotifier {
  late bool _isNameValid = true;
  late bool _isAddressValid = true;
  late bool _isCityValid = true;
  late bool _isEmailValid = true;
  late bool _isWebValid = true;
  late bool _isNumberValid = true;
  late bool _isHourValid = true;
  late final bool _isValid = true;
  late bool _productType0 = true;
  late bool _productType1 = true;
  late bool _productType2 = true;
  late bool _productName = true;
  late bool _desctiotion = true;
  late bool _price = true;
  late bool _qunantity = true;
  late bool _done = true;

  bool get done => _done;
  bool get isValid => _isValid;
  bool get isNameValid => _isNameValid;
  bool get isAddressValid => _isAddressValid;
  bool get isCityValid => _isCityValid;
  bool get isEmailValid => _isEmailValid;
  bool get isWebValid => _isWebValid;
  bool get isNumberValid => _isNumberValid;
  bool get isHourValid => _isHourValid;

  ///?ProductType Validation
  bool get productType0 => _productType0;
  bool get productType1 => _productType1;
  bool get productType2 => _productType2;

  ///?Product Validation
  bool get productName => _productName;
  bool get desctiotion => _desctiotion;
  bool get price => _price;
  bool get qunantiyy => _qunantity;

  businessName(String value) {
    if (value.length >= 5) {
      _isNameValid = false;
    } else {
      _isNameValid = true;
    }
    return _isNameValid ? "it has to be more then five letters" : "✔";
  }

  businessAddress(String value) {
    if (value.length >= 5) {
      _isAddressValid = false;
    } else {
      _isAddressValid = true;
    }
    return _isAddressValid ? "it has to be more then five letters" : "✔";
  }

  businessCity(String value) {
    if (value.length >= 5) {
      _isCityValid = false;
    } else {
      _isCityValid = true;
    }
    return _isCityValid ? "it has to be more then five letters" : "✔";
  }

  businessWeb(String value) {
    if (value.length >= 5) {
      _isWebValid = false;
    } else {
      _isWebValid = true;
    }
    return _isWebValid ? "it has to be more then five letters" : "✔";
  }

  businessEmail(String value) {
    if (value.length >= 5) {
      _isEmailValid = false;
    } else {
      _isEmailValid = true;
    }
    return _isEmailValid ? "it has to be more then five letters" : "✔";
  }

  businessPhone(String value) {
    if (value.length >= 5) {
      _isNumberValid = false;
    } else {
      _isNumberValid = true;
    }
    return _isNumberValid ? "the number it's not valid" : "✔";
  }

  isValidHour(String value) {
    if (value.length >= 5) {
      _isHourValid = false;
    } else {
      _isHourValid = true;
    }
    return _isHourValid ? "Enter working Hours" : "✔";
  }

  isValidproductType0(String value) {
    if (value.length >= 5) {
      _productType0 = false;
    } else {
      _productType0 = true;
    }
    return _productType0 ? "it has to be more then five letters" : "✔";
  }

  isValidproductType1(String value) {
    if (value.length >= 5) {
      _productType1 = false;
    } else {
      _productType1 = true;
    }
    return _productType1 ? "it has to be more then five letters" : "✔";
  }

  isValidproductType2(String value) {
    if (value.length >= 5) {
      _productType2 = false;
    } else {
      _productType2 = true;
    }
    return _productType2 ? "it has to be more then five letters" : "✔";
  }

  //? Product Validation
  isProductNameValid(String value) {
    if (value.length >= 5) {
      _productName = false;
    } else {
      _productName = true;
    }
    return _productName ? "it has to be more then five letters" : "✔";
  }

  ispriceValid(String value) {
    if (value.length >= 5) {
      _price = false;
    } else {
      _price = true;
    }
    return _price ? "the number it's not valid" : "✔";
  }

  isDescription(String value) {
    if (value.length >= 5) {
      _desctiotion = false;
    } else {
      _desctiotion = true;
    }
    return _desctiotion ? "it has to be more then five letters" : "✔";
  }

  isQuantity(String value) {
    if (value.length <= 1) {
      _qunantity = false;
    } else {
      _qunantity = true;
    }
    return _qunantity ? "the number it's not valid" : "✔";
  }

  vaildtionCheck(bool val) {
    _done = val;
  }
}
