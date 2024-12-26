import 'dart:convert';

import 'package:compass_software/data/entity/template_implants_intrument_entity.dart';

TemplateImplantInstrumentFiltercategory templateImplantInstrumentFiltercategoryFromJson(
        String str) =>
    TemplateImplantInstrumentFiltercategory.fromJson(json.decode(str));

class TemplateImplantInstrumentFiltercategory {
  ImplantInstrumentEntity? implantInstruments;

  TemplateImplantInstrumentFiltercategory({
    this.implantInstruments,
  });

  factory TemplateImplantInstrumentFiltercategory.fromJson(Map<String, dynamic> json) =>
      TemplateImplantInstrumentFiltercategory(
        implantInstruments:
            json["values"] == null ? null : ImplantInstrumentEntity.fromJson(json["values"]),
      );
}
