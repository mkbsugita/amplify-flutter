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

import 'dart:async';
import 'dart:typed_data';

import 'package:amplify_core/amplify_core.dart';
import 'package:amplify_storage_s3_dart/amplify_storage_s3_dart.dart';
import 'package:amplify_storage_s3_dart/src/sdk/s3.dart' as s3;
import 'package:amplify_storage_s3_dart/src/storage_s3_service/storage_s3_service.dart';
import 'package:amplify_storage_s3_dart/src/storage_s3_service/transfer/transfer.dart'
    as transfer;
import 'package:mocktail/mocktail.dart';
import 'package:smithy/smithy.dart' as smithy;
import 'package:test/test.dart';

import '../../test_utils/mocks.dart';
import '../../test_utils/test_custom_prefix_resolver.dart';

void main() {
  group('S3UploadTask', () {
    late s3.S3Client s3Client;
    late AWSLogger logger;
    late transfer.TransferDatabase transferDatabase;
    const testBucket = 'fake-bucket';
    final testPrefixResolver = TestCustomPrefixResolver();

    setUpAll(() {
      s3Client = MockS3Client();
      logger = MockAWSLogger();
      transferDatabase = MockTransferDatabase();

      registerFallbackValue(
        s3.PutObjectRequest(bucket: 'fake bucket', key: 'dummy key'),
      );
      registerFallbackValue(
        s3.HeadObjectRequest(bucket: 'fake bucket', key: 'dummy key'),
      );

      registerFallbackValue(
        s3.CreateMultipartUploadRequest(
          bucket: 'fake bucket',
          key: 'dummy key',
        ),
      );

      registerFallbackValue(
        s3.UploadPartRequest(
          bucket: 'fake bucket',
          key: 'dummy key',
          uploadId: 'uploadId',
        ),
      );

      registerFallbackValue(
        s3.CompleteMultipartUploadRequest(
          bucket: 'fake bucket',
          key: 'dummy key',
          uploadId: 'uploadId',
        ),
      );

      registerFallbackValue(
        s3.AbortMultipartUploadRequest(
          bucket: 'fake bucket',
          key: 'dummy key',
          uploadId: 'uploadId',
        ),
      );

      registerFallbackValue(
        const transfer.TransferRecordsCompanion(),
      );
    });

    group('Uploading S3DataPayload', () {
      final testDataPayload = S3DataPayload.string('Upload me please!');
      const testKey = 'object-upload-to';

      test('should invoke S3Client.putObject API with expected parameters',
          () async {
        const testUploadDataOptions = S3StorageUploadDataOptions(
          storageAccessLevel: StorageAccessLevel.private,
        );
        final testPutObjectOutput = s3.PutObjectOutput();

        when(
          () => s3Client.putObject(any()),
        ).thenAnswer((_) async => testPutObjectOutput);

        final uploadDataTask = S3UploadTask.fromDataPayload(
          testDataPayload,
          s3Client: s3Client,
          prefixResolver: testPrefixResolver,
          bucket: testBucket,
          key: testKey,
          options: testUploadDataOptions,
          logger: logger,
          transferDatabase: transferDatabase,
        );

        unawaited(uploadDataTask.start());

        final result = await uploadDataTask.result;

        expect(result.key, testKey);

        final capturedRequest = verify(
          () => s3Client.putObject(captureAny<s3.PutObjectRequest>()),
        ).captured.last;

        expect(capturedRequest is s3.PutObjectRequest, isTrue);
        final request = capturedRequest as s3.PutObjectRequest;
        expect(request.bucket, testBucket);
        expect(
          request.key,
          '${await testPrefixResolver.resolvePrefix(
            storageAccessLevel: testUploadDataOptions.storageAccessLevel,
          )}$testKey',
        );
        expect(request.body, testDataPayload);
      });

      test(
          'should invoke S3Client.headObject API with correct parameters when getProperties is set to true in the options',
          () async {
        const testUploadDataOptions = S3StorageUploadDataOptions(
          storageAccessLevel: StorageAccessLevel.private,
          getProperties: true,
        );
        final testPutObjectOutput = s3.PutObjectOutput();
        final testHeadObjectOutput = s3.HeadObjectOutput();

        when(
          () => s3Client.putObject(any()),
        ).thenAnswer((_) async => testPutObjectOutput);

        when(
          () => s3Client.headObject(any()),
        ).thenAnswer((_) async => testHeadObjectOutput);

        final uploadDataTask = S3UploadTask.fromDataPayload(
          testDataPayload,
          s3Client: s3Client,
          prefixResolver: testPrefixResolver,
          bucket: testBucket,
          key: testKey,
          options: testUploadDataOptions,
          logger: logger,
          transferDatabase: transferDatabase,
        );

        unawaited(uploadDataTask.start());
        await uploadDataTask.result;

        final capturedRequest = verify(
          () => s3Client.headObject(captureAny<s3.HeadObjectRequest>()),
        ).captured.last;

        expect(capturedRequest is s3.HeadObjectRequest, isTrue);
        final request = capturedRequest as s3.HeadObjectRequest;
        expect(request.bucket, testBucket);
        expect(
          request.key,
          '${await testPrefixResolver.resolvePrefix(
            storageAccessLevel: testUploadDataOptions.storageAccessLevel,
          )}$testKey',
        );
      });

      test('should throw S3StorageException when prefix resolving fails', () {
        const testUploadDataOptions = S3StorageUploadDataOptions(
          storageAccessLevel: StorageAccessLevel.private,
        );
        final prefixResolverThrowsException =
            TestCustomPrefixResolverThrowsException();

        final uploadDataTask = S3UploadTask.fromDataPayload(
          testDataPayload,
          s3Client: s3Client,
          prefixResolver: prefixResolverThrowsException,
          bucket: testBucket,
          key: testKey,
          options: testUploadDataOptions,
          logger: logger,
          transferDatabase: transferDatabase,
        );

        unawaited(uploadDataTask.start());
        expect(uploadDataTask.result, throwsA(isA<S3StorageException>()));
      });

      test('should throw S3StorageException when S3Client.putObject fails', () {
        const testUploadDataOptions = S3StorageUploadDataOptions(
          storageAccessLevel: StorageAccessLevel.private,
        );
        const testException = smithy.UnknownSmithyHttpException(
          statusCode: 403,
          body: 'Access denied!',
        );

        when(
          () => s3Client.putObject(any()),
        ).thenThrow(testException);

        final uploadDataTask = S3UploadTask.fromDataPayload(
          testDataPayload,
          s3Client: s3Client,
          prefixResolver: testPrefixResolver,
          bucket: testBucket,
          key: testKey,
          options: testUploadDataOptions,
          logger: logger,
          transferDatabase: transferDatabase,
        );

        unawaited(uploadDataTask.start());

        expect(uploadDataTask.result, throwsA(isA<S3StorageException>()));
      });
    });

    group('Uploading AWSFile (<=5MB) - putObject', () {
      final testBytes = [101, 102, 103];
      final testLocalFile = AWSFile.fromStream(
        Stream.value(testBytes),
        size: testBytes.length,
      );
      const testKey = 'object-upload-to';

      test('should invoke S3Client.putObject with expected parameters',
          () async {
        const testUploadDataOptions = S3StorageUploadDataOptions(
          storageAccessLevel: StorageAccessLevel.private,
        );
        final testPutObjectOutput = s3.PutObjectOutput();
        when(
          () => s3Client.putObject(any()),
        ).thenAnswer((_) async => testPutObjectOutput);

        final uploadDataTask = S3UploadTask.fromAWSFile(
          testLocalFile,
          s3Client: s3Client,
          prefixResolver: testPrefixResolver,
          bucket: testBucket,
          key: testKey,
          options: testUploadDataOptions,
          logger: logger,
          transferDatabase: transferDatabase,
        );

        unawaited(uploadDataTask.start());

        final result = await uploadDataTask.result;

        expect(result.key, testKey);

        final capturedRequest = verify(
          () => s3Client.putObject(captureAny<s3.PutObjectRequest>()),
        ).captured.last;

        expect(capturedRequest is s3.PutObjectRequest, isTrue);
        final request = capturedRequest as s3.PutObjectRequest;
        expect(request.bucket, testBucket);
        expect(
          request.key,
          '${await testPrefixResolver.resolvePrefix(
            storageAccessLevel: testUploadDataOptions.storageAccessLevel,
          )}$testKey',
        );
        expect(await request.body?.toList(), equals([testBytes]));
      });
    });

    group('Uploading AWSFile (> 5MB)', () {
      final testBytes = Uint8List(11 * 1024 * 1024); // 11MB
      late Stream<List<int>> testFileReadStream;
      late AWSFile testLocalFile;
      const testKey = 'object-upload-to';

      setUp(() {
        testFileReadStream = _getBytesStream(testBytes);
        testLocalFile = AWSFile.fromStream(
          testFileReadStream,
          size: testBytes.length,
          contentType: 'image/png',
        );
      });

      test(
          'should invoke corresponding S3Client APIs with in a happy path to complete the upload',
          () async {
        final receivedState = <S3TransferState>[];
        void onProgress(S3TransferProgress progress) {
          receivedState.add(progress.state);
        }

        const testUploadDataOptions = S3StorageUploadDataOptions(
          storageAccessLevel: StorageAccessLevel.protected,
          getProperties: true,
          metadata: {'filename': 'png.png'},
        );
        const testMultipartUploadId = 'awesome-upload';

        final testCreateMultipartUploadOutput = s3.CreateMultipartUploadOutput(
          uploadId: testMultipartUploadId,
        );
        when(
          () => s3Client.createMultipartUpload(any()),
        ).thenAnswer((_) async => testCreateMultipartUploadOutput);

        when(
          () => transferDatabase.insertTransferRecord(any()),
        ).thenAnswer((_) async => 1);

        final testUploadPartOutput1 = s3.UploadPartOutput(eTag: 'eTag-part-1');
        final testUploadPartOutput2 = s3.UploadPartOutput(eTag: 'eTag-part-2');
        final testUploadPartOutput3 = s3.UploadPartOutput(eTag: 'eTag-part-3');
        when(
          () => s3Client.uploadPart(any()),
        ).thenAnswer((invocation) async {
          final request =
              invocation.positionalArguments.first as s3.UploadPartRequest;

          switch (request.partNumber) {
            case 1:
              return testUploadPartOutput1;
            case 2:
              return testUploadPartOutput2;
            case 3:
              return testUploadPartOutput3;
          }

          throw Exception('this is not going to happen in this test setup');
        });

        final testCompleteMultipartUploadOutput =
            s3.CompleteMultipartUploadOutput();
        when(
          () => s3Client.completeMultipartUpload(any()),
        ).thenAnswer((_) async => testCompleteMultipartUploadOutput);

        when(
          () => transferDatabase.deleteTransferRecords(any()),
        ).thenAnswer((_) async => 1);

        final testHeadObjectOutput = s3.HeadObjectOutput();
        when(
          () => s3Client.headObject(any()),
        ).thenAnswer((_) async => testHeadObjectOutput);

        final uploadTask = S3UploadTask.fromAWSFile(
          testLocalFile,
          s3Client: s3Client,
          prefixResolver: testPrefixResolver,
          bucket: testBucket,
          key: testKey,
          options: testUploadDataOptions,
          logger: logger,
          transferDatabase: transferDatabase,
          onProgress: onProgress,
        );

        unawaited(uploadTask.start());

        await uploadTask.result;

        // verify generated CreateMultipartUploadRequest
        final capturedCreateMultipartUploadRequest = verify(
          () => s3Client.createMultipartUpload(
            captureAny<s3.CreateMultipartUploadRequest>(),
          ),
        ).captured.last;
        expect(
          capturedCreateMultipartUploadRequest,
          isA<s3.CreateMultipartUploadRequest>(),
        );
        final createMultipartUploadRequest =
            capturedCreateMultipartUploadRequest
                as s3.CreateMultipartUploadRequest;
        expect(createMultipartUploadRequest.bucket, testBucket);
        expect(
          createMultipartUploadRequest.key,
          '${await testPrefixResolver.resolvePrefix(
            storageAccessLevel: testUploadDataOptions.storageAccessLevel,
          )}$testKey',
        );
        expect(
          capturedCreateMultipartUploadRequest.metadata?['filename'],
          testUploadDataOptions.metadata?['filename'],
        );
        final capturedTransferDBInsertParam = verify(
          () => transferDatabase.insertTransferRecord(
            captureAny<transfer.TransferRecordsCompanion>(),
          ),
        ).captured.last;
        expect(
          capturedTransferDBInsertParam,
          isA<transfer.TransferRecordsCompanion>().having(
            (o) => o.uploadId.value,
            'uploadId',
            testMultipartUploadId,
          ),
        );

        // verify uploadPart calls
        final uploadPartVerification = verify(
          () => s3Client.uploadPart(captureAny<s3.UploadPartRequest>()),
        )..called(3); // 11MB file creates 3 upload part requests
        final capturedUploadPartRequests = uploadPartVerification.captured;
        final partNumbers = <int>[];
        final bytes = BytesBuilder();

        await Future.forEach(capturedUploadPartRequests,
            (capturedRequest) async {
          expect(capturedRequest, isA<s3.UploadPartRequest>());
          final request = capturedRequest as s3.UploadPartRequest;
          expect(request.bucket, testBucket);
          expect(
            request.key,
            '${await testPrefixResolver.resolvePrefix(
              storageAccessLevel: testUploadDataOptions.storageAccessLevel,
            )}$testKey',
          );
          partNumbers.add(request.partNumber);
          bytes.add(
            await request.body!.toList().then(
                  (collectedBytes) =>
                      collectedBytes.expand((bytes) => bytes).toList(),
                ),
          );
        });
        expect(bytes.takeBytes(), equals(testBytes));
        expect(partNumbers, equals([1, 2, 3]));
        expect(
          receivedState,
          List.generate(4, (_) => S3TransferState.inProgress)
            ..add(S3TransferState.success),
        ); // upload start + 3 parts

        // verify the CompleteMultipartUpload request
        final capturedCompleteMultipartUploadRequest = verify(
          () => s3Client.completeMultipartUpload(
            captureAny<s3.CompleteMultipartUploadRequest>(),
          ),
        ).captured.last;
        expect(
          capturedCompleteMultipartUploadRequest,
          isA<s3.CompleteMultipartUploadRequest>(),
        );
        final completeMultipartUploadRequest =
            capturedCompleteMultipartUploadRequest
                as s3.CompleteMultipartUploadRequest;
        expect(completeMultipartUploadRequest.bucket, testBucket);
        expect(
          completeMultipartUploadRequest.key,
          '${await testPrefixResolver.resolvePrefix(
            storageAccessLevel: testUploadDataOptions.storageAccessLevel,
          )}$testKey',
        );

        final capturedTransferDBDeleteParam = verify(
          () => transferDatabase.deleteTransferRecords(
            captureAny(),
          ),
        ).captured.last;
        expect(
          capturedTransferDBDeleteParam,
          testMultipartUploadId,
        );
      });

      test(
          'should throw exception if the file to be upload is too large to initiate a multipart upload',
          () async {
        late S3TransferState finalState;
        final testBadFile =
            AWSFile.fromStream(Stream.value([]), size: 10001 * 5 * 1024 * 1024);
        final uploadTask = S3UploadTask.fromAWSFile(
          testBadFile,
          s3Client: s3Client,
          prefixResolver: testPrefixResolver,
          bucket: testBucket,
          key: testKey,
          options: const S3StorageUploadDataOptions(),
          logger: logger,
          transferDatabase: transferDatabase,
          onProgress: (progress) {
            finalState = progress.state;
          },
        );

        unawaited(uploadTask.start());

        await expectLater(
          uploadTask.result,
          throwsA(isA<S3StorageException>()),
        );
        expect(finalState, S3TransferState.failure);
      });

      test('should complete with error when CreateMultipartUploadRequest fails',
          () async {
        late S3TransferState finalState;
        final uploadTask = S3UploadTask.fromAWSFile(
          testLocalFile,
          s3Client: s3Client,
          prefixResolver: testPrefixResolver,
          bucket: testBucket,
          key: testKey,
          options: const S3StorageUploadDataOptions(),
          logger: logger,
          transferDatabase: transferDatabase,
          onProgress: (progress) {
            finalState = progress.state;
          },
        );

        const testException = smithy.UnknownSmithyHttpException(
          statusCode: 403,
          body: 'Access denied!',
        );

        when(
          () => s3Client.createMultipartUpload(any()),
        ).thenThrow(testException);

        unawaited(uploadTask.start());

        await expectLater(
          uploadTask.result,
          throwsA(
            isA<S3StorageException>()
              ..having(
                (o) => o.underlyingException,
                'underlyingException',
                testException,
              ),
          ),
        );

        expect(finalState, S3TransferState.failure);
      });

      test(
          'should complete with error when CreateMultipartUploadRequest does NOT return a valid uploadId',
          () async {
        late S3TransferState finalState;
        final uploadTask = S3UploadTask.fromAWSFile(
          testLocalFile,
          s3Client: s3Client,
          prefixResolver: testPrefixResolver,
          bucket: testBucket,
          key: testKey,
          options: const S3StorageUploadDataOptions(),
          logger: logger,
          transferDatabase: transferDatabase,
          onProgress: (progress) {
            finalState = progress.state;
          },
        );

        final testCreateMultipartUploadOutput = s3.CreateMultipartUploadOutput(
          uploadId: null, // response should always contain valid uploadId
        );
        when(
          () => s3Client.createMultipartUpload(any()),
        ).thenAnswer((_) async => testCreateMultipartUploadOutput);

        unawaited(uploadTask.start());

        await expectLater(
          uploadTask.result,
          throwsA(isA<S3StorageException>()),
        );
        expect(finalState, S3TransferState.failure);
      });

      test(
          'should complete with error when CompleteMultipartUploadRequest fails (should not happen just in case)',
          () async {
        late S3TransferState finalState;
        final uploadTask = S3UploadTask.fromAWSFile(
          testLocalFile,
          s3Client: s3Client,
          prefixResolver: testPrefixResolver,
          bucket: testBucket,
          key: testKey,
          options: const S3StorageUploadDataOptions(),
          logger: logger,
          transferDatabase: transferDatabase,
          onProgress: (progress) {
            finalState = progress.state;
          },
        );

        final testCreateMultipartUploadOutput = s3.CreateMultipartUploadOutput(
          uploadId: 'some-upload-id',
        );
        when(
          () => s3Client.createMultipartUpload(any()),
        ).thenAnswer((_) async => testCreateMultipartUploadOutput);

        when(
          () => transferDatabase.insertTransferRecord(any()),
        ).thenAnswer((_) async => 1);

        final testUploadPartOutput = s3.UploadPartOutput(eTag: 'eTag-part-1');
        when(
          () => s3Client.uploadPart(any()),
        ).thenAnswer((_) async => testUploadPartOutput);

        const testException = smithy.UnknownSmithyHttpException(
          statusCode: 403,
          body: 'Access denied!',
        );
        when(
          () => s3Client.completeMultipartUpload(any()),
        ).thenThrow(testException);

        unawaited(uploadTask.start());

        await expectLater(
          uploadTask.result,
          throwsA(
            isA<S3StorageException>()
              ..having(
                (o) => o.underlyingException,
                'underlyingException',
                testException,
              ),
          ),
        );
        expect(finalState, S3TransferState.failure);
      });

      test(
          'should terminate multipart upload when a UploadPartRequest fails and should complete with error',
          () async {
        late S3TransferState finalState;
        final uploadTask = S3UploadTask.fromAWSFile(
          testLocalFile,
          s3Client: s3Client,
          prefixResolver: testPrefixResolver,
          bucket: testBucket,
          key: testKey,
          options: const S3StorageUploadDataOptions(),
          logger: logger,
          transferDatabase: transferDatabase,
          onProgress: (progress) {
            finalState = progress.state;
          },
        );
        const testMultipartUploadId = 'some-upload-id';

        final testCreateMultipartUploadOutput = s3.CreateMultipartUploadOutput(
          uploadId: testMultipartUploadId,
        );
        when(
          () => s3Client.createMultipartUpload(any()),
        ).thenAnswer((_) async => testCreateMultipartUploadOutput);

        when(
          () => transferDatabase.insertTransferRecord(any()),
        ).thenAnswer((_) async => 1);

        const testException = smithy.UnknownSmithyHttpException(
          statusCode: 403,
          body: 'Access denied!',
        );
        when(
          () => s3Client.uploadPart(any()),
        ).thenThrow(testException);

        unawaited(uploadTask.start());

        final testAbortMultipartUploadOutput = s3.AbortMultipartUploadOutput();
        when(
          () => s3Client.abortMultipartUpload(any()),
        ).thenAnswer((_) async => testAbortMultipartUploadOutput);

        await expectLater(
          uploadTask.result,
          throwsA(
            isA<S3StorageException>()
              ..having(
                (o) => o.underlyingException,
                'underlyingException',
                testException,
              ),
          ),
        );

        final capturedAbortMultipartUploadRequest = verify(
          () => s3Client.abortMultipartUpload(
            captureAny<s3.AbortMultipartUploadRequest>(),
          ),
        ).captured.last;

        expect(
          capturedAbortMultipartUploadRequest,
          isA<s3.AbortMultipartUploadRequest>().having(
            (o) => o.uploadId,
            'uploadId',
            testMultipartUploadId,
          ),
        );
        expect(finalState, S3TransferState.failure);
      });

      test(
          'should terminate multipart upload when a UploadPartRequest does NOT return a valid eTag and complete with error',
          () async {
        late S3TransferState finalState;
        final uploadTask = S3UploadTask.fromAWSFile(
          testLocalFile,
          s3Client: s3Client,
          prefixResolver: testPrefixResolver,
          bucket: testBucket,
          key: testKey,
          options: const S3StorageUploadDataOptions(),
          logger: logger,
          transferDatabase: transferDatabase,
          onProgress: (progress) {
            finalState = progress.state;
          },
        );
        const testMultipartUploadId = 'some-upload-id';

        final testCreateMultipartUploadOutput = s3.CreateMultipartUploadOutput(
          uploadId: testMultipartUploadId,
        );
        when(
          () => s3Client.createMultipartUpload(any()),
        ).thenAnswer((_) async => testCreateMultipartUploadOutput);

        when(
          () => transferDatabase.insertTransferRecord(any()),
        ).thenAnswer((_) async => 1);

        final testUploadPartOutput = s3.UploadPartOutput(eTag: null);
        when(
          () => s3Client.uploadPart(any()),
        ).thenAnswer((_) async => testUploadPartOutput);

        unawaited(uploadTask.start());

        final testAbortMultipartUploadOutput = s3.AbortMultipartUploadOutput();
        when(
          () => s3Client.abortMultipartUpload(any()),
        ).thenAnswer((_) async => testAbortMultipartUploadOutput);

        await expectLater(
          uploadTask.result,
          throwsA(isA<S3StorageException>()),
        );

        expect(finalState, S3TransferState.failure);
      });

      test(
          'should terminate multipart upload when a UploadPartRequest encountered NoSuchUpload error and complete with error',
          () async {
        late S3TransferState finalState;
        final uploadTask = S3UploadTask.fromAWSFile(
          testLocalFile,
          s3Client: s3Client,
          prefixResolver: testPrefixResolver,
          bucket: testBucket,
          key: testKey,
          options: const S3StorageUploadDataOptions(),
          logger: logger,
          transferDatabase: transferDatabase,
          onProgress: (progress) {
            finalState = progress.state;
          },
        );
        const testMultipartUploadId = 'some-upload-id';

        final testCreateMultipartUploadOutput = s3.CreateMultipartUploadOutput(
          uploadId: testMultipartUploadId,
        );
        when(
          () => s3Client.createMultipartUpload(any()),
        ).thenAnswer((_) async => testCreateMultipartUploadOutput);

        when(
          () => transferDatabase.insertTransferRecord(any()),
        ).thenAnswer((_) async => 1);

        final testException = s3.NoSuchUpload();
        when(
          () => s3Client.uploadPart(any()),
        ).thenThrow(testException);

        unawaited(uploadTask.start());

        final testAbortMultipartUploadOutput = s3.AbortMultipartUploadOutput();
        when(
          () => s3Client.abortMultipartUpload(any()),
        ).thenAnswer((_) async => testAbortMultipartUploadOutput);

        await expectLater(
          uploadTask.result,
          throwsA(
            isA<S3StorageException>()
              ..having(
                (o) => o.underlyingException,
                'underlyingException',
                testException,
              ),
          ),
        );
        expect(finalState, S3TransferState.failure);
      });

      group('Control APIs', () {
        setUpAll(() {
          final testCreateMultipartUploadOutput =
              s3.CreateMultipartUploadOutput(
            uploadId: 'some-upload-id',
          );
          when(
            () => s3Client.createMultipartUpload(any()),
          ).thenAnswer((_) async => testCreateMultipartUploadOutput);

          when(
            () => transferDatabase.insertTransferRecord(any()),
          ).thenAnswer((_) async => 1);

          final testUploadPartOutput = s3.UploadPartOutput(eTag: 'eTag-part-1');
          when(
            () => s3Client.uploadPart(any()),
          ).thenAnswer((invocation) async {
            final request =
                invocation.positionalArguments.first as s3.UploadPartRequest;

            if (request.partNumber == 2) {
              await Future<void>.delayed(const Duration(milliseconds: 500));
            }
            return testUploadPartOutput;
          });

          final testCompleteMultipartUploadOutput =
              s3.CompleteMultipartUploadOutput();
          when(
            () => s3Client.completeMultipartUpload(any()),
          ).thenAnswer((_) async => testCompleteMultipartUploadOutput);

          when(
            () => transferDatabase.deleteTransferRecords(any()),
          ).thenAnswer((_) async => 1);

          final testAbortMultipartUploadOutput =
              s3.AbortMultipartUploadOutput();
          when(
            () => s3Client.abortMultipartUpload(any()),
          ).thenAnswer((_) async => testAbortMultipartUploadOutput);
        });

        test('pause()/resume() should emit paused stat and complete the upload',
            () async {
          final receivedState = <S3TransferState>[];
          final uploadTask = S3UploadTask.fromAWSFile(
            testLocalFile,
            s3Client: s3Client,
            prefixResolver: testPrefixResolver,
            bucket: testBucket,
            key: testKey,
            options: const S3StorageUploadDataOptions(),
            logger: logger,
            transferDatabase: transferDatabase,
            onProgress: (progress) {
              receivedState.add(progress.state);
            },
          );

          unawaited(uploadTask.start());

          await uploadTask.pause();
          // expect(receivedState.last, S3TransferState.paused);

          await uploadTask.resume();
          // expect(receivedState.last, S3TransferState.inProgress);

          await uploadTask.result;
          expect(
            receivedState,
            contains(S3TransferState.paused),
          );
        });

        test(
            'cancel() should terminate ongoing multipart upload and throw a S3StorageException',
            () async {
          final receivedState = <S3TransferState>[];
          final uploadTask = S3UploadTask.fromAWSFile(
            testLocalFile,
            s3Client: s3Client,
            prefixResolver: testPrefixResolver,
            bucket: testBucket,
            key: testKey,
            options: const S3StorageUploadDataOptions(),
            logger: logger,
            transferDatabase: transferDatabase,
            onProgress: (progress) {
              receivedState.add(progress.state);
            },
          );

          unawaited(uploadTask.start());

          await uploadTask.cancel();

          expect(
            uploadTask.result,
            throwsA(isA<S3StorageException>()),
          );
        });
      });
    });
  });
}

Stream<List<int>> _getBytesStream(Uint8List bytes) async* {
  const chunkSize = 64 * 1024;
  var currentPosition = 0;
  while (currentPosition < bytes.length) {
    final readRange = currentPosition + chunkSize > bytes.length
        ? bytes.length
        : currentPosition + chunkSize;
    yield bytes.sublist(currentPosition, readRange);
    currentPosition += chunkSize;
  }
}