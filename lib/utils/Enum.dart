class EnumTypeMatch {
  final _value;

  const EnumTypeMatch._internal(this._value);

  toString() => _value;

  static const player = const EnumTypeMatch._internal('1');
  static const club = const EnumTypeMatch._internal('2');
}

class EnumTypeField {
  final _value;

  const EnumTypeField._internal(this._value);

  toString() => _value;

  static const field5 = const EnumTypeField._internal('5');
  static const field7 = const EnumTypeField._internal('7');
  static const field11 = const EnumTypeField._internal('11');
}
