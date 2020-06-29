enum Measure { Travel, Transport, Electricity }
enum CalculationAnimationType { Good, Ok, Bad }
enum UserStatus{LoggedIn,EmailNotVerified, LoggedOut}

String enumToString(_enum) {
  String _enumValue;
  if (_enum != null)
    _enumValue = _enum.toString().split('.').last.toLowerCase();
  return _enumValue;
}

Measure measureStringToEnum(value) {
  Measure measure;
  switch (value) {
    case 'transport':
      measure = Measure.Transport;
      break;
    case 'travel':
      measure = Measure.Travel;
      break;
    case 'electricity':
      measure = Measure.Electricity;
      break;
  }
  return measure;
}

CalculationAnimationType animationToEnum(value) {
  CalculationAnimationType _enum;
  switch (value) {
    case 'bad':
      _enum = CalculationAnimationType.Bad;
      break;
    case 'good':
      _enum = CalculationAnimationType.Good;
      break;
    case 'ok':
      _enum = CalculationAnimationType.Ok;
      break;
  }
  return _enum;
}
