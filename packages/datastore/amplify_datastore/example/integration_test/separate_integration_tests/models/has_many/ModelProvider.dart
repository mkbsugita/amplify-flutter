// Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
// SPDX-License-Identifier: Apache-2.0

// NOTE: This file is generated and may not follow lint rules defined in your app
// Generated files can be excluded from analysis in analysis_options.yaml
// For more info, see: https://dart.dev/guides/language/analysis-options#excluding-code-from-analysis

// ignore_for_file: public_member_api_docs, file_names, unnecessary_new, prefer_if_null_operators, prefer_const_constructors, slash_for_doc_comments, annotate_overrides, non_constant_identifier_names, unnecessary_string_interpolations, prefer_adjacent_string_concatenation, unnecessary_const, dead_code

import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';

import '../../../../lib/models/HasManyChildExplicit.dart';
import '../../../../lib/models/HasManyChildImplicit.dart';
import '../../../../lib/models/HasManyParent.dart';

export '../../../../lib/models/HasManyChildExplicit.dart';
export '../../../../lib/models/HasManyChildImplicit.dart';
export '../../../../lib/models/HasManyParent.dart';

class ModelProvider implements ModelProviderInterface {
  @override
  String version = "c4d29b43024b973d2fd3ba65fe7f0a5b";
  @override
  List<ModelTypeDefinition> modelSchemas = [
    HasManyChildExplicit.schema,
    HasManyChildImplicit.schema,
    HasManyParent.schema,
  ];
  static final ModelProvider _instance = ModelProvider();
  @override
  List<ModelTypeDefinition> customTypeSchemas = [];

  static ModelProvider get instance => _instance;

  ModelType getModelTypeByModelName(String modelName) {
    switch (modelName) {
      case "HasManyChildExplicit":
        return HasManyChildExplicit.classType;
      case "HasManyChildImplicit":
        return HasManyChildImplicit.classType;
      case "HasManyParent":
        return HasManyParent.classType;
      default:
        throw Exception(
            "Failed to find model in model provider for model name: " +
                modelName);
    }
  }
}