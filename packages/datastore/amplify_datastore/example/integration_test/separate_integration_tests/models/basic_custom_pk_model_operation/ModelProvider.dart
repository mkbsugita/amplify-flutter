// Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
// SPDX-License-Identifier: Apache-2.0

// NOTE: This file is generated and may not follow lint rules defined in your app
// Generated files can be excluded from analysis in analysis_options.yaml
// For more info, see: https://dart.dev/guides/language/analysis-options#excluding-code-from-analysis

// ignore_for_file: public_member_api_docs, file_names, unnecessary_new, prefer_if_null_operators, prefer_const_constructors, slash_for_doc_comments, annotate_overrides, non_constant_identifier_names, unnecessary_string_interpolations, prefer_adjacent_string_concatenation, unnecessary_const, dead_code

import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';

import '../../../../lib/models/CpkInventory.dart';

export '../../../../lib/models/CpkInventory.dart';

class ModelProvider implements ModelProviderInterface {
  @override
  String version = "f80fece878bf91a76f44577fe599b120";
  @override
<<<<<<<< HEAD:packages/datastore/amplify_datastore/test/test_models/ModelProvider.dart
  List<ModelTypeDefinition> modelSchemas = [
    Blog.schema,
    Comment.schema,
    Post.schema,
    StringListTypeModel.schema
========
  List<ModelSchema> modelSchemas = [
    CpkInventory.schema,
>>>>>>>> aws/next:packages/datastore/amplify_datastore/example/integration_test/separate_integration_tests/models/basic_custom_pk_model_operation/ModelProvider.dart
  ];
  static final ModelProvider _instance = ModelProvider();
  @override
  List<ModelTypeDefinition> customTypeSchemas = [];

  static ModelProvider get instance => _instance;

  ModelType getModelTypeByModelName(String modelName) {
    switch (modelName) {
      case "CpkInventory":
        return CpkInventory.classType;
      default:
        throw Exception(
            "Failed to find model in model provider for model name: " +
                modelName);
    }
  }
}