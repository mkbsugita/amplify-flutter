// Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
// SPDX-License-Identifier: Apache-2.0

import 'package:amplify_core/amplify_core.dart';

/// {@macro amplify_core.auth.auth_sign_in_step}
@Deprecated('''
Use AuthSignInStep instead. These steps are generic and not specific to Cognito.
''')
typedef CognitoSignInStep = AuthSignInStep;
