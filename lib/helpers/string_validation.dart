abstract class StringValidation {
  const StringValidation();

  String? validate(String? value);
}

class StringValidationComposite extends StringValidation {
  final List<StringValidation> validations;

  const StringValidationComposite({required this.validations});

  @override
  String? validate(String? value) {
    String? result;
    for (int i = 0; i < validations.length; i++) {
      final validationResult = validations[i].validate(value);
      if (validationResult == null) continue;
      if (validationResult.isNotEmpty) {
        result = validationResult;
        break;
      }
    }
    return result;
  }
}

class IsEmptyStringValidation extends StringValidation {
  const IsEmptyStringValidation();

  @override
  String? validate(String? value) {
    value = value ?? '';
    if (value.trim().isEmpty) {
      return 'Field must not be empty';
    }
    return null;
  }
}

class IsTooShortString extends StringValidation {
  final int size;
  const IsTooShortString({required this.size});

  @override
  String? validate(String? value) {
    value = value ?? '';
    if (value.length < size) {
      return 'Should be at least $size characters long (${value.length})';
    }
    return null;
  }
}

class IsTooLongString extends StringValidation {
  final int size;
  const IsTooLongString({required this.size});

  @override
  String? validate(String? value) {
    value = value ?? '';
    if (value.length > size) {
      return 'Should be less than $size characters long (${value.length})';
    }
    return null;
  }
}

class IsImageUrlString extends StringValidation {
  @override
  String? validate(String? value) {
    value = value ?? '';
    bool isValidUrl = Uri.tryParse(value)?.hasAbsolutePath ?? false;

    String toLower = value.toLowerCase();
    bool isValidFormat = toLower.endsWith('.png') ||
        toLower.endsWith('.jpg') ||
        toLower.endsWith('.jpeg');

    if (isValidUrl && isValidFormat) return null;
    return 'Invalid Image Url';
  }
}

class IsValidPriceString extends StringValidation {
  @override
  String? validate(String? value) {
    value = value ?? '-1';
    final price = double.tryParse(value) ?? -1;
    if (price <= 0) return 'Provide a valid price';
    return null;
  }
}
