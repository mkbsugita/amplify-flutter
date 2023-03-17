// Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
// SPDX-License-Identifier: Apache-2.0

package com.amazonaws.amplify.amplify_push_notifications

import androidx.lifecycle.DefaultLifecycleObserver
import androidx.lifecycle.LifecycleOwner
import io.flutter.Log


private const val TAG = "AmplifyLifecycleObserver"

class AmplifyLifecycleObserver : DefaultLifecycleObserver {
    override fun onResume(owner: LifecycleOwner) {
        refreshToken()
        super.onResume(owner)
    }
    override fun onCreate(owner: LifecycleOwner) {
        refreshToken()
        super.onCreate(owner)
    }
}
