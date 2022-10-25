// Copyright 2022 Amazon.com, Inc. or its affiliates. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:amplify_core/amplify_core.dart';
import 'package:amplify_storage_s3_dart/amplify_storage_s3_dart.dart';
import 'package:amplify_storage_s3_dart/src/prefix_resolver/storage_access_level_aware_prefix_resolver.dart';
import 'package:amplify_storage_s3_dart/src/storage_s3_service/storage_s3_service.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'test_utils/mocks.dart';
import 'test_utils/test_custom_prefix_resolver.dart';
import 'test_utils/test_token_provider.dart';

void main() {
  const testDefaultStorageAccessLevel = StorageAccessLevel.private;
  const testConfig = AmplifyConfig(
    storage: StorageConfig(
      plugins: {
        S3PluginConfig.pluginKey: S3PluginConfig(
          bucket: '123',
          region: 'west-2',
          defaultAccessLevel: testDefaultStorageAccessLevel,
        )
      },
    ),
  );

  final testAuthProviderRepo = AmplifyAuthProviderRepository()
    ..registerAuthProvider(
      APIAuthorizationType.userPools.authProviderToken,
      TestTokenIdentityProvider(),
    )
    ..registerAuthProvider(
      APIAuthorizationType.iam.authProviderToken,
      TestIamAuthProvider(),
    );

  group('AmplifyStorageS3Dart', () {
    late DependencyManager dependencyManager;
    late StorageS3Service storageS3Service;

    setUp(() async {
      dependencyManager = DependencyManager();
      storageS3Service = MockStorageS3Service();

      when(
        () => storageS3Service.abortIncompleteMultipartUploads(),
      ).thenAnswer((_) async {});
    });

    tearDown(() {
      dependencyManager.close();
    });

    test('constructor should take in custom prefix resolver', () {
      final s3Plugin = AmplifyStorageS3Dart(
        prefixResolver: TestCustomPrefixResolver(),
        dependencyManagerOverride: dependencyManager,
      );
      final prefixResolver = s3Plugin.prefixResolver;
      expect(prefixResolver is TestCustomPrefixResolver, isTrue);
    });

    test(
        'configure should set up default prefix resolver when custom prefix resolver is NOT supplied',
        () async {
      final s3Plugin = AmplifyStorageS3Dart(
        dependencyManagerOverride: dependencyManager,
      );
      await s3Plugin.configure(
        config: testConfig,
        authProviderRepo: testAuthProviderRepo,
      );
      dependencyManager.addInstance<StorageS3Service>(storageS3Service);
      final prefixResolver = s3Plugin.prefixResolver;
      expect(prefixResolver is StorageAccessLevelAwarePrefixResolver, isTrue);
    });

    test(
        'configure should set identityProvider for the default prefix resolver',
        () async {
      final s3Plugin = AmplifyStorageS3Dart(
        dependencyManagerOverride: dependencyManager,
      );
      await s3Plugin.configure(
        config: testConfig,
        authProviderRepo: testAuthProviderRepo,
      );
      dependencyManager.addInstance<StorageS3Service>(storageS3Service);
      final prefixResolver =
          s3Plugin.prefixResolver as StorageAccessLevelAwarePrefixResolver;
      final identityProvider = prefixResolver.identityProvider;
      expect(
        identityProvider,
        testAuthProviderRepo.getAuthProvider(
          APIAuthorizationType.userPools.authProviderToken,
        ),
      );
    });
  });

  group('AmplifyStorageS3Dart API', () {
    late DependencyManager dependencyManager;
    late AmplifyStorageS3Dart storageS3Plugin;
    late StorageS3Service storageS3Service;

    setUp(() async {
      dependencyManager = DependencyManager();
      storageS3Service = MockStorageS3Service();
      storageS3Plugin = AmplifyStorageS3Dart(
        dependencyManagerOverride: dependencyManager,
      );

      await storageS3Plugin.configure(
        config: testConfig,
        authProviderRepo: testAuthProviderRepo,
      );

      dependencyManager.addInstance<StorageS3Service>(storageS3Service);

      when(
        () => storageS3Service.abortIncompleteMultipartUploads(),
      ).thenAnswer((_) async {});
    });

    tearDown(() {
      dependencyManager.close();
    });

    group('list()', () {
      const testPath = 'some/path';
      final testResult = S3StorageListResult(
        <S3StorageItem>[],
        hasNext: false,
        next: () async {
          return S3StorageListResult(
            [],
            hasNext: false,
            next: () async {
              throw UnimplementedError();
            },
          );
        },
      );

      setUpAll(() {
        registerFallbackValue(const S3StorageListOptions());
      });

      test(
          'should forward options with default StorageAccessLevel to to StorageS3Service.list() API',
          () {
        const testRequest =
            StorageListRequest<S3StorageListOptions>(path: testPath);

        when(
          () => storageS3Service.list(
            path: testPath,
            options: any(named: 'options'),
          ),
        ).thenAnswer(
          (_) async => testResult,
        );

        storageS3Plugin.list(request: testRequest);

        final capturedOptions = verify(
          () => storageS3Service.list(
            path: testPath,
            options: captureAny<S3StorageListOptions>(named: 'options'),
          ),
        ).captured.last;

        expect(
          capturedOptions,
          isA<S3StorageListOptions>().having(
            (o) => o.storageAccessLevel,
            'storageAccessLevel',
            testDefaultStorageAccessLevel,
          ),
        );
      });
    });

    group('getProperties()', () {
      const testKey = 'some-object-key';
      final testResult = S3StorageGetPropertiesResult(
        storageItem: S3StorageItem(
          key: testKey,
          lastModified: DateTime(2022, 9, 19),
          eTag: '12345',
          size: 1024,
          metadata: {
            'filename': 'file.jpg',
            'uploader': 'user-id',
          },
        ),
      );

      setUpAll(() {
        registerFallbackValue(const S3StorageGetPropertiesOptions());
      });

      test(
          'should forward options with default StorageAccessLevel to StorageS3Service.getProperties() API',
          () {
        const testRequest =
            StorageGetPropertiesRequest<S3StorageGetPropertiesOptions>(
          key: testKey,
        );

        when(
          () => storageS3Service.getProperties(
            key: testKey,
            options: any(named: 'options'),
          ),
        ).thenAnswer(
          (_) async => testResult,
        );

        storageS3Plugin.getProperties(request: testRequest);

        final capturedOptions = verify(
          () => storageS3Service.getProperties(
            key: testKey,
            options:
                captureAny<S3StorageGetPropertiesOptions>(named: 'options'),
          ),
        ).captured.last;

        expect(
          capturedOptions,
          isA<S3StorageGetPropertiesOptions>().having(
            (o) => o.storageAccessLevel,
            'storageAccessLevel',
            testDefaultStorageAccessLevel,
          ),
        );
      });
    });

    group('getUrl() API', () {
      const testKey = 'some-object-key';
      final testResult = S3StorageGetUrlResult(
        url: Uri(
          host: 's3.amazon.aws',
          path: 'album/1.jpg',
          scheme: 'https',
        ),
      );

      setUpAll(() {
        registerFallbackValue(const S3StorageGetUrlOptions());
      });

      test(
          'should forward options with default StorageAccessLevel to StorageS3Service.getUrl() API',
          () async {
        const testRequest = StorageGetUrlRequest(key: testKey);

        when(
          () => storageS3Service.getUrl(
            key: testKey,
            options: any(named: 'options'),
          ),
        ).thenAnswer(
          (_) async => testResult,
        );

        final getUrlOperation = storageS3Plugin.getUrl(request: testRequest);

        final capturedOptions = verify(
          () => storageS3Service.getUrl(
            key: testKey,
            options: captureAny<S3StorageGetUrlOptions>(named: 'options'),
          ),
        ).captured.last;

        expect(
          capturedOptions,
          isA<S3StorageGetUrlOptions>().having(
            (o) => o.storageAccessLevel,
            'storageAccessLevel',
            testDefaultStorageAccessLevel,
          ),
        );

        final result = await getUrlOperation.result;
        expect(result.url, testResult.url);
      });
    });

    group('downloadData() API', () {
      const testKey = 'some-object-key';
      final testItem = S3StorageItem(
        key: testKey,
        lastModified: DateTime(2022, 9, 19),
        eTag: '12345',
        size: 1024,
        metadata: {
          'filename': 'file.jpg',
          'uploader': 'user-id',
        },
      );
      final testS3DownloadTask = MockS3DownloadTask();
      late S3StorageDownloadDataOperation downloadDataOperation;

      setUpAll(() {
        registerFallbackValue(const S3StorageDownloadDataOptions());
      });

      test(
          'should forward options with default StorageAccessLevel to StorageS3Service.downloadData API',
          () async {
        const testRequest =
            StorageDownloadDataRequest<S3StorageDownloadDataOptions>(
          key: testKey,
        );

        when(
          () => storageS3Service.downloadData(
            key: testKey,
            options: any(named: 'options'),
            preStart: any(named: 'preStart'),
            onProgress: any(named: 'onProgress'),
            onData: any(named: 'onData'),
            onDone: any(named: 'onDone'),
          ),
        ).thenAnswer((_) => testS3DownloadTask);

        when(() => testS3DownloadTask.result).thenAnswer((_) async => testItem);

        downloadDataOperation = storageS3Plugin.downloadData(
          request: testRequest,
        );

        final capturedOptions = verify(
          () => storageS3Service.downloadData(
            key: testKey,
            options: captureAny<S3StorageDownloadDataOptions>(named: 'options'),
            preStart: any(named: 'preStart'),
            onProgress: any(named: 'onProgress'),
            onData: any(named: 'onData'),
            onDone: any(named: 'onDone'),
          ),
        ).captured.last;

        expect(
          capturedOptions,
          isA<S3StorageDownloadDataOptions>().having(
            (o) => o.storageAccessLevel,
            'storageAccessLevel',
            testDefaultStorageAccessLevel,
          ),
        );

        final result = await downloadDataOperation.result;
        expect(result.bytes.isEmpty, true);
        expect(result.downloadedItem, testItem);
      });

      test(
          'S3DownloadDataOperation pause resume and cancel APIs should interact with S3DownloadTask',
          () async {
        when(testS3DownloadTask.pause).thenAnswer((_) async {});
        when(testS3DownloadTask.resume).thenAnswer((_) async {});
        when(testS3DownloadTask.cancel).thenAnswer((_) async {});

        await downloadDataOperation.pause();
        await downloadDataOperation.resume();
        await downloadDataOperation.cancel();

        verify(testS3DownloadTask.pause).called(1);
        verify(testS3DownloadTask.resume).called(1);
        verify(testS3DownloadTask.cancel).called(1);
      });
    });

    group('uploadData() API', () {
      const testKey = 'object-upload-to';
      final testItem = S3StorageItem(
        key: testKey,
        lastModified: DateTime(2022, 10, 14),
        eTag: '12345',
        size: 1024,
        metadata: {
          'filename': 'file.jpg',
          'uploader': 'user-id',
        },
      );
      final testS3UploadTask = MockS3UploadTask();
      late S3StorageUploadDataOperation uploadDataOperation;

      setUpAll(() {
        registerFallbackValue(const S3StorageUploadDataOptions());
        registerFallbackValue(S3DataPayload());
      });

      test(
          'should forward options with default StorageAccessLevel to StorageS3Service.uploadData API',
          () async {
        final testRequest = StorageUploadDataRequest(
          data: S3DataPayload.string('Hello S3.'),
          key: testKey,
        );

        when(
          () => storageS3Service.uploadData(
            key: testKey,
            dataPayload: any(named: 'dataPayload'),
            options: any(named: 'options'),
            onProgress: any(named: 'onProgress'),
            onDone: any(named: 'onDone'),
            onError: any(named: 'onError'),
          ),
        ).thenAnswer((_) => testS3UploadTask);

        when(() => testS3UploadTask.result).thenAnswer((_) async => testItem);

        uploadDataOperation = storageS3Plugin.uploadData(request: testRequest);

        final capturedParams = verify(
          () => storageS3Service.uploadData(
            key: testKey,
            dataPayload: captureAny<S3DataPayload>(named: 'dataPayload'),
            options: captureAny<S3StorageUploadDataOptions>(named: 'options'),
            onProgress: any(named: 'onProgress'),
            onDone: any(named: 'onDone'),
            onError: any(named: 'onError'),
          ),
        ).captured;

        final capturedDataPayload = capturedParams[0];
        final capturedOptions = capturedParams[1];

        expect(capturedDataPayload, testRequest.data);

        expect(
          capturedOptions,
          isA<S3StorageUploadDataOptions>().having(
            (o) => o.storageAccessLevel,
            'storageAccessLevel',
            testDefaultStorageAccessLevel,
          ),
        );

        final result = await uploadDataOperation.result;
        expect(result.uploadedItem, testItem);
      });

      // test(
      //     'S3UploadDataOperation pause resume and cancel APIs should interact with S3DownloadTask',
      //     () async {
      //   when(testS3UploadTask.pause).thenAnswer((_) async {});
      //   when(testS3UploadTask.resume).thenAnswer((_) async {});
      //   when(testS3UploadTask.cancel).thenAnswer((_) async {});

      //   await uploadDataOperation.pause();
      //   await uploadDataOperation.resume();
      //   await uploadDataOperation.cancel();

      //   verify(testS3UploadTask.pause).called(1);
      //   verify(testS3UploadTask.resume).called(1);
      //   verify(testS3UploadTask.cancel).called(1);
      // });
    });

    group('uploadFile() API', () {
      const testKey = 'object-upload-to';
      final testItem = S3StorageItem(
        key: testKey,
        lastModified: DateTime(2022, 10, 14),
        eTag: '12345',
        size: 1024,
        metadata: {
          'filename': 'file.jpg',
          'uploader': 'user-id',
        },
      );
      final testS3UploadTask = MockS3UploadTask();
      late S3StorageUploadFileOperation uploadFileOperation;

      setUpAll(() {
        registerFallbackValue(const S3StorageUploadFileOptions());
        registerFallbackValue(const S3StorageUploadDataOptions());
        registerFallbackValue(S3DataPayload());
        registerFallbackValue(AWSFile.fromData([]));
      });

      test(
          'should forward options with default StorageAccessLevel to StorageS3Service.uploadFile API',
          () async {
        final testRequest = StorageUploadFileRequest(
          localFile: AWSFile.fromData([101]),
          key: testKey,
        );

        when(
          () => storageS3Service.uploadFile(
            key: testKey,
            localFile: any(named: 'localFile'),
            options: any(named: 'options'),
            onProgress: any(named: 'onProgress'),
            onDone: any(named: 'onDone'),
            onError: any(named: 'onError'),
          ),
        ).thenAnswer((_) => testS3UploadTask);

        when(() => testS3UploadTask.result).thenAnswer((_) async => testItem);

        uploadFileOperation = storageS3Plugin.uploadFile(request: testRequest);

        final capturedParams = verify(
          () => storageS3Service.uploadFile(
            key: testKey,
            localFile: captureAny<AWSFile>(named: 'localFile'),
            options: captureAny<S3StorageUploadFileOptions>(named: 'options'),
            onProgress: any(named: 'onProgress'),
            onDone: any(named: 'onDone'),
            onError: any(named: 'onError'),
          ),
        ).captured;

        final capturedLocalFile = capturedParams[0];
        final capturedOptions = capturedParams[1];

        expect(capturedLocalFile, testRequest.localFile);

        expect(
          capturedOptions,
          isA<S3StorageUploadFileOptions>().having(
            (o) => o.storageAccessLevel,
            'storageAccessLevel',
            testDefaultStorageAccessLevel,
          ),
        );

        final result = await uploadFileOperation.result;
        expect(result.uploadedItem, testItem);
      });

      // TODO(HuiSF): enable this test when upload opeartion regain the control
      //  APIs.
      // test(
      //     'S3DownloadUploadOperation pause resume and cancel APIs should interact with S3DownloadTask',
      //     () async {
      //   when(testS3UploadTask.pause).thenAnswer((_) async {});
      //   when(testS3UploadTask.resume).thenAnswer((_) async {});
      //   when(testS3UploadTask.cancel).thenAnswer((_) async {});

      //   await uploadFileOperation.pause();
      //   await uploadFileOperation.resume();
      //   await uploadFileOperation.cancel();

      //   verify(testS3UploadTask.pause).called(1);
      //   verify(testS3UploadTask.resume).called(1);
      //   verify(testS3UploadTask.cancel).called(1);
      // });
    });

    group('copy() API', () {
      const testTargetIdentityId = 'someone-else';
      const testSourceItem = S3StorageItem(key: 'source');
      const testDestinationItem = S3StorageItem(key: 'destination');
      const testSource = S3StorageItemWithAccessLevel(
        storageItem: testSourceItem,
      );
      const testDestination = S3StorageItemWithAccessLevel.forIdentity(
        testTargetIdentityId,
        storageItem: testDestinationItem,
      );
      const testResult = S3StorageCopyResult(copiedItem: testDestinationItem);

      setUpAll(() {
        registerFallbackValue(const S3StorageCopyOptions());
      });

      test(
          'should forward options with default getProperties value to StorageS3Service.copy() API',
          () async {
        const testRequest = StorageCopyRequest(
          source: testSource,
          destination: testDestination,
        );

        when(
          () => storageS3Service.copy(
            source: testSource,
            destination: testDestination,
            options: any(named: 'options'),
          ),
        ).thenAnswer((_) async => testResult);

        final copyOperation = storageS3Plugin.copy(request: testRequest);

        final capturedOptions = verify(
          () => storageS3Service.copy(
            source: testSource,
            destination: testDestination,
            options: captureAny<S3StorageCopyOptions>(named: 'options'),
          ),
        ).captured.last;

        expect(
          capturedOptions,
          isA<S3StorageCopyOptions>().having(
            (o) => o.getProperties,
            'getProperties',
            false,
          ),
        );

        final result = await copyOperation.result;
        expect(result, testResult);
      });
    });

    group('move() API', () {
      const testSourceItem = S3StorageItem(key: 'source');
      const testDestinationItem = S3StorageItem(key: 'destination');
      const testSource = S3StorageItemWithAccessLevel(
        storageItem: testSourceItem,
        storageAccessLevel: StorageAccessLevel.private,
      );
      const testDestination = S3StorageItemWithAccessLevel(
        storageItem: testDestinationItem,
        storageAccessLevel: StorageAccessLevel.guest,
      );
      const testResult = S3StorageMoveResult(movedItem: testDestinationItem);

      setUpAll(() {
        registerFallbackValue(const S3StorageMoveOptions());
      });

      test(
          'should forward options with default getProperties value to StorageS3Service.move() API',
          () async {
        const testRequest = StorageMoveRequest(
          source: testSource,
          destination: testDestination,
        );

        when(
          () => storageS3Service.move(
            source: testSource,
            destination: testDestination,
            options: any(named: 'options'),
          ),
        ).thenAnswer((_) async => testResult);

        final moveOperation = storageS3Plugin.move(request: testRequest);

        final capturedOptions = verify(
          () => storageS3Service.move(
            source: testSource,
            destination: testDestination,
            options: captureAny<S3StorageMoveOptions>(named: 'options'),
          ),
        ).captured.last;

        expect(
          capturedOptions,
          isA<S3StorageMoveOptions>().having(
            (o) => o.getProperties,
            'getProperties',
            false,
          ),
        );

        final result = await moveOperation.result;
        expect(result, testResult);
      });
    });

    group('remove() API', () {
      const testKey = 'object-to-remove';
      const testResult = S3StorageRemoveResult(
        removedItem: S3StorageItem(
          key: testKey,
        ),
      );

      setUpAll(() {
        registerFallbackValue(const S3StorageRemoveOptions());
      });

      test(
          'should forward options with default StorageAccessLevel StorageS3Service.remove() API',
          () async {
        const testRequest = StorageRemoveRequest(key: testKey);

        when(
          () => storageS3Service.remove(
            key: testKey,
            options: any(named: 'options'),
          ),
        ).thenAnswer((_) async => testResult);

        final removeOperation = storageS3Plugin.remove(request: testRequest);

        final capturedOptions = verify(
          () => storageS3Service.remove(
            key: testKey,
            options: captureAny<S3StorageRemoveOptions>(named: 'options'),
          ),
        ).captured.last;

        expect(
          capturedOptions,
          isA<S3StorageRemoveOptions>().having(
            (o) => o.storageAccessLevel,
            'storageAccessLevel',
            testDefaultStorageAccessLevel,
          ),
        );

        final result = await removeOperation.result;
        expect(result, testResult);
      });
    });

    group('removeMany() API', () {
      final testKeys = List.generate(
        20,
        (index) => 'object-to-remove-${index + 1}',
      );
      final resultRemoveItems =
          testKeys.map((key) => S3StorageItem(key: key)).toList();
      final testResult = S3StorageRemoveManyResult(
        removedItems: resultRemoveItems,
      );

      setUpAll(() {
        registerFallbackValue(const S3StorageRemoveManyOptions());
      });

      test(
          'should forward options with default StorageAccessLevel StorageS3Service.removeMany() API',
          () async {
        final testRequest = StorageRemoveManyRequest(keys: testKeys);

        when(
          () => storageS3Service.removeMany(
            keys: testKeys,
            options: any(named: 'options'),
          ),
        ).thenAnswer((_) async => testResult);

        final removeManyOperation =
            storageS3Plugin.removeMany(request: testRequest);

        final capturedOptions = verify(
          () => storageS3Service.removeMany(
            keys: testKeys,
            options: captureAny(named: 'options'),
          ),
        ).captured.last;

        expect(
          capturedOptions,
          isA<S3StorageRemoveManyOptions>().having(
            (o) => o.storageAccessLevel,
            'storageAccessLevel',
            testDefaultStorageAccessLevel,
          ),
        );

        final result = await removeManyOperation.result;
        expect(result.removedItems, resultRemoveItems);
      });
    });
  });
}