/*
 * Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License").
 * You may not use this file except in compliance with the License.
 * A copy of the License is located at
 *
 *  http://aws.amazon.com/apache2.0
 *
 * or in the "license" file accompanying this file. This file is distributed
 * on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
 * express or implied. See the License for the specific language governing
 * permissions and limitations under the License.
 */

import 'package:integration_test/integration_test.dart';
import 'package:flutter_test/flutter_test.dart';

import '../utils/setup_utils.dart';
import '../utils/test_cloud_synced_model_operation.dart';
import 'models/cpk_has_many_bidirectional/ModelProvider.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('HasMany (bi-directional with implicit connection field', () {
    // schema
    // type CpkHasManyParentBidirectionalImplicit @model {
    //   id: ID! @primaryKey(sortKeyFields: ["name"])
    //   name: String!
    //   bidirectionalImplicitChildren: [CpkHasManyChildBidirectionalImplicit] @hasMany
    // }

    // type CpkHasManyChildBidirectionalImplicit @model {
    //   id: ID! @primaryKey(sortKeyFields: ["name"])
    //   name: String!
    //   hasManyParent: CpkHasManyParentBidirectionalImplicit @belongsTo
    // }
    final enableCloudSync = shouldEnableCloudSync();
    var rootModels = [
      CpkHasManyParentBidirectionalImplicit(name: 'has many parent (explicit)')
    ];
    var associatedModels = List.generate(
      5,
      (i) => CpkHasManyChildBidirectionalImplicit(
        name: 'has many child $i (explicit)',
        hasManyParent: rootModels.first,
      ),
    );
    var associatedModelQueryPredicates = associatedModels
        .map(
          (associatedModel) => CpkHasManyChildBidirectionalImplicit.NAME
              .eq(associatedModel.name),
        )
        .toList();

    testRootAndAssociatedModelsRelationship(
      modelProvider: ModelProvider.instance,
      rootModelType: CpkHasManyParentBidirectionalImplicit.classType,
      rootModels: rootModels,
      rootModelQueryIdentifier:
          CpkHasManyParentBidirectionalImplicit.MODEL_IDENTIFIER,
      associatedModelType: CpkHasManyChildBidirectionalImplicit.classType,
      associatedModels: associatedModels,
      associatedModelQueryIdentifier:
          CpkHasManyChildBidirectionalImplicit.MODEL_IDENTIFIER,
      associatedModelQueryPredicates: associatedModelQueryPredicates,
      supportCascadeDelete: true,
      enableCloudSync: enableCloudSync,
      verifyBelongsToPopulating: true,
    );
  });
}
