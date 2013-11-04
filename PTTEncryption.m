/*
 *  PTTEncryption.m
 *  psyTrack Clinician Tools
 *  Version: 1.5.4
 *
 *
 *	THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY UNITED STATES
 *	INTELLECTUAL PROPERTY LAW AND INTERNATIONAL TREATIES. UNAUTHORIZED REPRODUCTION OR
 *	DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES.
 *
 *  Created by Daniel Boice on 2/15/12.
 *  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
 *
 *
 *	This notice may not be removed from this file.
 *
 */
/*
   contains code from:
   File: SecKeyWrapper.h
   Abstract: Core cryptographic wrapper class to exercise most of the Security
   APIs on the iPhone OS. Start here if all you are interested in are the
   cryptographic APIs on the iPhone OS.

   Version: 1.2

   Disclaimer: IMPORTANT:  This Apple software is supplied to you by Apple Inc.
   ("Apple") in consideration of your agreement to the following terms, and your
   use, installation, modification or redistribution of this Apple software
   constitutes acceptance of these terms.  If you do not agree with these terms,
   please do not use, install, modify or redistribute this Apple software.

   In consideration of your agreement to abide by the following terms, and subject
   to these terms, Apple grants you a personal, non-exclusive license, under
   Apple's copyrights in this original Apple software (the "Apple Software"), to
   use, reproduce, modify and redistribute the Apple Software, with or without
   modifications, in source and/or binary forms; provided that if you redistribute
   the Apple Software in its entirety and without modifications, you must retain
   this notice and the following text and disclaimers in all such redistributions
   of the Apple Software.
   Neither the name, trademarks, service marks or logos of Apple Inc. may be used
   to endorse or promote products derived from the Apple Software without specific
   prior written permission from Apple.  Except as expressly stated in this notice,
   no other rights or licenses, express or implied, are granted by Apple herein,
   including but not limited to any patent rights that may be infringed by your
   derivative works or by other works in which the Apple Software may be
   incorporated.

   The Apple Software is provided by Apple on an "AS IS" basis.  APPLE MAKES NO
   WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION THE IMPLIED
   WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS FOR A PARTICULAR
   PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND OPERATION ALONE OR IN
   COMBINATION WITH YOUR PRODUCTS.

   IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL OR
   CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
   GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
   ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION, MODIFICATION AND/OR
   DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED AND WHETHER UNDER THEORY OF
   CONTRACT, TORT (INCLUDING NEGLIGENCE), STRICT LIABILITY OR OTHERWISE, EVEN IF
   APPLE HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

   Copyright (C) 2008-2009 Apple Inc. All Rights Reserved.

 */

#import "PTTEncryption.h"
//#import "NSDataExtentionAES256.h"

@implementation PTTEncryption
@synthesize ableToProceed = ableToProceed_;
@synthesize publicTag, privateTag, symmetricTag, symmetricKeyRef;

#if DEBUG
#  define LOGGING_FACILITY(X, Y) \
    NSAssert(X, Y);

#  define LOGGING_FACILITY1(X, Y, Z) \
    NSAssert1(X, Y, Z);
#else /* if DEBUG */
#  define LOGGING_FACILITY(X, Y) \
    if ( !(X) ) {                \
                                 \
    }

#  define LOGGING_FACILITY1(X, Y, Z) \
    if ( !(X) ) {                    \
                                     \
    }
#endif /* if DEBUG */

//#if TARGET_IPHONE_SIMULATOR
//
//// Dummy implementations for no-building simulator target (reduce compiler warnings)
//
//- (void)setObject:(id)inObject forKey:(id)key {}
//- (id)objectForKey:(id)key { return nil; }
//// Dummy implementations for my SecKeyWrapper class.
//- (void)generateKeyPair:(NSUInteger)keySize {}
//- (void)deleteAsymmetricKeys {}
//- (void)deleteSymmetricKey {}
//- (void)generateSymmetricKey {}
//- (NSData *)getSymmetricKeyBytes { return NULL; }
//- (SecKeyRef)addPeerPublicKey:(NSString *)peerName keyBits:(NSData *)publicKey { return NULL; }
//- (void)removePeerPublicKey:(NSString *)peerName {}
//- (NSData *)wrapSymmetricKey:(NSData *)symmetricKey keyRef:(SecKeyRef)publicKey { return nil; }
//- (NSData *)unwrapSymmetricKey:(NSData *)wrappedSymmetricKey { return nil; }
//- (NSData *)getSignatureBytes:(NSData *)plainText { return nil; }
//- (NSData *)getHashBytes:(NSData *)plainText { return nil; }
//- (BOOL)verifySignature:(NSData *)plainText secKeyRef:(SecKeyRef)publicKey signature:(NSData *)sig { return NO; }
//- (NSData *)doCipher:(NSData *)plainText key:(NSData *)symmetricKey context:(CCOperation)encryptOrDecrypt padding:(CCOptions *)pkcs7 { return nil; }
//- (SecKeyRef)getPublicKeyRef { return nil; }
//- (NSData *)getPublicKeyBits { return nil; }
//- (SecKeyRef)getPrivateKeyRef { return nil; }
//- (CFTypeRef)getPersistentKeyRefWithKeyRef:(SecKeyRef)keyRef { return NULL; }
//- (SecKeyRef)getKeyRefWithPersistentKeyRef:(CFTypeRef)persistentRef { return NULL; }
//#else

// (See cssmtype.h and cssmapple.h on the Mac OS X SDK.)

enum {
    CSSM_ALGID_NONE = 0x00000000L,
    CSSM_ALGID_VENDOR_DEFINED = CSSM_ALGID_NONE + 0x80000000L,
    CSSM_ALGID_AES
};

// identifiers used to find public, private, and symmetric key.
static const uint8_t publicKeyIdentifier[] = kPublicKeyTag;
static const uint8_t privateKeyIdentifier[] = kPrivateKeyTag;
static const uint8_t symmetricKeyIdentifier[] = kSymmetricKeyTag;

NSString *trustResultDescribe( SecTrustResultType result )
{
    static NSString *const kTrustResultNames[kSecTrustResultOtherError + 1] = {
        @"Invalid",
        @"Proceed",
        @"Confirm",
        @"Deny",
        @"Unspecified",
        @"RecoverableTrustFailure",
        @"FatalTrustFailure",
        @"OtherError"
    };
    if (result <= kSecTrustResultOtherError)
    {
        return kTrustResultNames[result];
    }
    else
    {
        return [NSString stringWithFormat:@"(Unknown trust result %u)", result];
    }
}


- (id) init
{
    if (self = [super init])
    {
        // Tag data to search for keys.
        privateTag = [[NSData alloc] initWithBytes:privateKeyIdentifier length:sizeof(privateKeyIdentifier)];
        publicTag = [[NSData alloc] initWithBytes:publicKeyIdentifier length:sizeof(publicKeyIdentifier)];
        symmetricTag = [[NSData alloc] initWithBytes:symmetricKeyIdentifier length:sizeof(symmetricKeyIdentifier)];
    }

    return self;
}


- (BOOL) identityAndTrustResult
{
    BOOL shouldProceed = NO;
    NSString *thePath = [[NSBundle mainBundle]

                         pathForResource:@"apns" ofType:@"p12"];

    NSData *PKCS12Data = [[NSData alloc] initWithContentsOfFile:thePath];

    CFDataRef inPKCS12Data = (__bridge CFDataRef)PKCS12Data;             // 1

//
    OSStatus status = noErr;

    SecIdentityRef myIdentity;

    CFStringRef password = CFSTR("yeethES447hafLB4");

    const void *keys[] = { kSecImportExportPassphrase };

    const void *values[] = { password };

    CFDictionaryRef optionsDictionary = CFDictionaryCreate(

        NULL, keys,

        values, 1,

        NULL, NULL);
    CFArrayRef items = CFArrayCreate(NULL, 0, 0, NULL);

    status = SecPKCS12Import(inPKCS12Data,

                             optionsDictionary,

                             &items);

    //1
    if (optionsDictionary)
    {
        CFRelease(optionsDictionary);
    }

    //1

    // Get the certificate from the identity.

    //1
    if (CFArrayGetCount(items) > 0 && status == noErr)
    {
        CFTypeRef valueAtIndexZero = CFArrayGetValueAtIndex(items, 0);

        CFMutableDictionaryRef fileSecObjectsDictionary = (CFMutableDictionaryRef)valueAtIndexZero;

        NSString *identityKeyString = @"identity";

        myIdentity = (SecIdentityRef)CFDictionaryGetValue(fileSecObjectsDictionary, (__bridge CFStringRef)identityKeyString);

        SecCertificateRef certificateRef;
        SecIdentityCopyCertificate(myIdentity, &certificateRef);
//        SecTrustRef *myTrust;

        NSString *trustKeyString = @"trust";
        SecTrustRef myTrust;
//
        myTrust = (SecTrustRef)CFDictionaryGetValue(fileSecObjectsDictionary, (__bridge CFStringRef)trustKeyString);
//

        NSString *chainString = @"chain";

        CFArrayRef CFChainArray = (CFArrayRef)CFDictionaryGetValue(fileSecObjectsDictionary, (__bridge CFStringRef)chainString);

        // Get the certificate from the identity.

        SecCertificateRef myReturnedCertificate = NULL;

        status = SecIdentityCopyCertificate(myIdentity,

                                            &myReturnedCertificate);   // 1

        //2
        if (status == noErr)
        {
            SecPolicyRef myPolicy = SecPolicyCreateBasicX509();         // 3

            SecCertificateRef certArray[1] = { certificateRef };

            CFArrayRef myCerts = CFArrayCreate( NULL, (void *)certArray,

                                                1, NULL);

            status = SecTrustCreateWithCertificates(myCerts, myPolicy, &myTrust);  // 4

            //3
            if (status == noErr)
            {
                status = (OSStatus)SecTrustSetAnchorCertificates(
                    (SecTrustRef)myTrust,
                    (CFArrayRef)CFChainArray
                    );

                SecTrustResultType trustResult;

                //4
                if (status == noErr)
                {
                    status = (OSStatus)SecTrustEvaluate( (SecTrustRef)myTrust, &trustResult );     // 5

                    //

                    // kSecTrustResultProceed -> trust ok, go right ahead
                    // kSecTrustResultConfirm -> trust ok, but user asked (earlier) that you check with him before proceeding
                    // kSecTrustResultDeny -> trust ok, but user previously said not to trust it anyway
                    // kSecTrustResultUnspecified -> trust ok, user has no particular opinion about this
                    // kSecTrustResultRecoverableTrustFailure -> trust broken, perhaps argue with the user
                    // kSecTrustResultFatalTrustFailure -> trust broken, user can't fix it
                    // kSecTrustResultOtherError -> something failed weirdly, abort operation
                    // kSecTrustResultInvalid -> logic error; fix your program (SecTrust was used incorrectly)

                    //5
                    if (status == noErr)
                    {
//
                        switch (trustResult)
                        {
                            case kSecTrustResultProceed:
                                // Accepted by user keychain setting explicitly
                                shouldProceed = TRUE;

                                break;
                            //                return TRUE;
                            case kSecTrustResultUnspecified:
                                // See http://developer.apple.com/qa/qa2007/qa1360.html
                                // Unspecified means that the user never expressed any persistent opinion about
                                // this certificate (or any of its signers). Either this is the first time this certificate
                                // has been encountered (in these circumstances), or the user has previously dealt with it
                                // on a one-off basis without recording a persistent decision. In practice, this is what
                                // most (cryptographically successful) evaluations return.
                                // If the certificate is invalid kSecTrustResultUnspecified can never be returned. NSNotification *trustResultFailureNotification=[NSNotification notificationWithName:@"securityKeyTrustResultFailure" object:self];
                            {
                                shouldProceed = TRUE;

                                //                return TRUE;
                            }
                            break;

                            case kSecTrustResultRecoverableTrustFailure:
                                // See http://developer.apple.com/qa/qa2007/qa1360.html

                                //6
                            {
                                //
                                //Get time used to verify trust

                                CFAbsoluteTime trustTime,currentTime,timeIncrement,newTime;

                                CFDateRef newDate;

                                trustTime = SecTrustGetVerifyTime(myTrust);

                                timeIncrement = 31536000;

                                currentTime = CFAbsoluteTimeGetCurrent();

                                newTime = currentTime - timeIncrement;
                                //7
                                if (trustTime - newTime)
                                {                                   // 7
                                    newDate = CFDateCreate(NULL, newTime);

                                    SecTrustSetVerifyDate(myTrust, newDate);

                                    status = SecTrustEvaluate(myTrust, &trustResult);
                                    //8
                                    if (newDate)
                                    {
                                        CFRelease(newDate);
                                    }

                                    //8
                                }

                                //7

//
                                //7
                                if ( (trustResult == kSecTrustResultProceed || trustResult == kSecTrustResultUnspecified || trustResult == kSecTrustResultRecoverableTrustFailure) && status == noErr )
                                {
                                    shouldProceed = TRUE;
                                }

                                //7
                                break;
                            }
                            //6
                            default:
                                break;
                        } /* switch */

                        //5
                        //5
                        if (shouldProceed)
                        {
                            publicKeyRef = (SecKeyRef)SecTrustCopyPublicKey(
                                (SecTrustRef)myTrust
                                );

                            status = (OSStatus)SecIdentityCopyPrivateKey(
                                (SecIdentityRef)myIdentity,
                                &privateKeyRef
                                );

                            //6
                            if (!privateKeyRef || status != noErr)
                            {
                                shouldProceed = FALSE;
                            }

                            //6
                        }
                        //5
                        else
                        //5
                        {
                            NSString *trustResultString = trustResultDescribe(trustResult);
                            @try
                            {
                                [[NSNotificationCenter defaultCenter]
                                 postNotificationName:@"trustFailureOccured"
                                               object:trustResultString];
                            }
                            @catch (NSException *exception)
                            {
                                //do nothing
                            }
                        }

                        //5
                    }

                    //4
                }

                //3
            }

            //2
            if (myCerts)
            {
                CFRelease(myCerts);
            }

            //2
            if (myTrust)
            {
                CFRelease(myTrust);
            }

            //2
            //2
            if (myPolicy)
            {
                CFRelease(myPolicy);
            }

            //2
            //2
            if (certificateRef)
            {
                CFRelease(certificateRef);
            }

            //2
        }

        //1
    }

    return shouldProceed;
}


- (NSData *) encryptData:(NSData *)data keyRef:(SecKeyRef)publicKey useDefaultPublicKey:(BOOL)useDefaultKey
{
    NSData *encryptedData = [self wrapSymmetricKey:(NSData *)data keyRef:(SecKeyRef)publicKey useDefaultPublicKey:(BOOL)useDefaultKey];

    return encryptedData;
}


- (NSData *) decryptData:(NSData *)data keyRef:(SecKeyRef)privateKey useDefaultPrivateKey:(BOOL)useDefaultKey
{
    NSData *unwrappedData = [self unwrapSymmetricKey:(NSData *)data keyRef:(SecKeyRef)privateKey useDefaultPrivateKey:(BOOL)useDefaultKey];

    return unwrappedData;
}


- (NSData *) wrapSymmetricKey:(NSData *)symmetricKey keyRef:(SecKeyRef)publicKey useDefaultPublicKey:(BOOL)useDefaultKey
{
    OSStatus sanityCheck = noErr;
    size_t cipherBufferSize = 0;
    size_t keyBufferSize = 0;

    if (symmetricKey == nil)
    {
        @throw @"Symmetric key parameter is nil.";
    }

    if (publicKey == nil)
    {
        if (useDefaultKey)
        {
            BOOL proceed = [self identityAndTrustResult];

            if (!proceed || publicKeyRef == nil)
            {
                @throw @"Was not able to verify security information";
                return nil;
            }
            else
            {
                publicKey = publicKeyRef;
            }
        }

//        else
//        {
//
//        }
    }

    NSData *cipher = nil;
    uint8_t *cipherBuffer = NULL;

    // Calculate the buffer sizes.
    cipherBufferSize = SecKeyGetBlockSize(publicKey);
    keyBufferSize = [symmetricKey length];

    if (kTypeOfWrapPadding == kSecPaddingNone)
    {
        LOGGING_FACILITY( keyBufferSize <= cipherBufferSize, @"Nonce integer is too large and falls outside multiplicative group." );
    }
    else
    {
        LOGGING_FACILITY( keyBufferSize <= (cipherBufferSize - 11), @"Nonce integer is too large and falls outside multiplicative group." );
    }

    // Allocate some buffer space. I don't trust calloc.
    cipherBuffer = malloc( cipherBufferSize * sizeof(uint8_t) );
    memset( (void *)cipherBuffer, 0x0, cipherBufferSize );

    // Encrypt using the public key.
    sanityCheck = SecKeyEncrypt(    publicKey,
                                    kTypeOfWrapPadding,
                                    (const uint8_t *)[symmetricKey bytes],
                                    keyBufferSize,
                                    cipherBuffer,
                                    &cipherBufferSize
                                    );

    if (sanityCheck != noErr)
    {
        // Build up cipher text blob.
        cipher = [NSData dataWithBytes:(const void *)cipherBuffer length:(NSUInteger)cipherBufferSize];
    }

    if (cipherBuffer)
    {
        free(cipherBuffer);
    }

    return cipher;
}


- (NSData *) unwrapSymmetricKey:(NSData *)wrappedSymmetricKey keyRef:(SecKeyRef)privateKey useDefaultPrivateKey:(BOOL)useDefaultKey
{
    OSStatus sanityCheck = noErr;
    size_t cipherBufferSize = 0;
    size_t keyBufferSize = 0;

    NSData *key = nil;
    uint8_t *keyBuffer = NULL;

    if (privateKey == nil)
    {
        if (useDefaultKey)
        {
            BOOL proceed = [self identityAndTrustResult];

            if (!proceed || privateKeyRef == nil)
            {
//
                return nil;
            }
            else
            {
                privateKey = privateKeyRef;
            }
        }

//        else
//        {
//
//        }
    }

    // Calculate the buffer sizes.
    cipherBufferSize = SecKeyGetBlockSize(privateKeyRef);
    keyBufferSize = [wrappedSymmetricKey length];

    LOGGING_FACILITY( keyBufferSize <= cipherBufferSize, @"Encrypted nonce is too large and falls outside multiplicative group." );

    // Allocate some buffer space. I don't trust calloc.
    keyBuffer = malloc( keyBufferSize * sizeof(uint8_t) );
    memset( (void *)keyBuffer, 0x0, keyBufferSize );

    // Decrypt using the private key.
    sanityCheck = SecKeyDecrypt(    privateKey,
                                    kTypeOfWrapPadding,
                                    (const uint8_t *)[wrappedSymmetricKey bytes],
                                    cipherBufferSize,
                                    keyBuffer,
                                    &keyBufferSize
                                    );

    LOGGING_FACILITY1( sanityCheck == noErr, @"Error decrypting, OSStatus == %ld", sanityCheck );

    // Build up plain text blob.
    key = [NSData dataWithBytes:(const void *)keyBuffer length:(NSUInteger)keyBufferSize];

    if (keyBuffer)
    {
        free(keyBuffer);
    }

    return key;
}


- (NSData *) getHashBytes:(NSData *)plainText
{
    CC_SHA1_CTX ctx;
    uint8_t *hashBytes = NULL;
    NSData *hash = nil;

    // Malloc a buffer to hold hash.
    hashBytes = malloc( kChosenDigestLength * sizeof(uint8_t) );
    memset( (void *)hashBytes, 0x0, kChosenDigestLength );

    // Initialize the context.
    CC_SHA1_Init(&ctx);
    // Perform the hash.
    CC_SHA1_Update(&ctx, (void *)[plainText bytes], [plainText length]);
    // Finalize the output.
    CC_SHA1_Final(hashBytes, &ctx);

    // Build up the SHA1 blob.
    hash = [NSData dataWithBytes:(const void *)hashBytes length:(NSUInteger)kChosenDigestLength];

    if (hashBytes)
    {
        free(hashBytes);
    }

    return hash;
}


- (NSData *) getSignatureBytes:(NSData *)plainText
{
    OSStatus sanityCheck = noErr;
    NSData *signedHash = nil;

    uint8_t *signedHashBytes = NULL;
    size_t signedHashBytesSize = 0;

    if (privateKeyRef == nil)
    {
        BOOL proceed = [self identityAndTrustResult];

        if (!proceed || privateKeyRef == nil)
        {
//
            return nil;
        }
    }

    signedHashBytesSize = SecKeyGetBlockSize(privateKeyRef);

    // Malloc a buffer to hold signature.
    signedHashBytes = malloc( signedHashBytesSize * sizeof(uint8_t) );
    memset( (void *)signedHashBytes, 0x0, signedHashBytesSize );

    // Sign the SHA1 hash.
    sanityCheck = SecKeyRawSign(    privateKeyRef,
                                    kTypeOfSigPadding,
                                    (const uint8_t *)[[self getHashBytes:plainText] bytes],
                                    kChosenDigestLength,
                                    (uint8_t *)signedHashBytes,
                                    &signedHashBytesSize
                                    );

//	LOGGING_FACILITY1( sanityCheck == noErr, @"Problem signing the SHA1 hash, OSStatus == %d.", sanityCheck );

    // Build up signed SHA1 blob.
    signedHash = [NSData dataWithBytes:(const void *)signedHashBytes length:(NSUInteger)signedHashBytesSize];

    if (signedHashBytes)
    {
        free(signedHashBytes);
    }

    return signedHash;
}


- (BOOL) verifySignature:(NSData *)plainText secKeyRef:(SecKeyRef)publicKey signature:(NSData *)sig
{
    size_t signedHashBytesSize = 0;
    OSStatus sanityCheck = noErr;

    // Get the size of the assymetric block.
    signedHashBytesSize = SecKeyGetBlockSize(publicKey);

    sanityCheck = SecKeyRawVerify(  publicKey,
                                    kTypeOfSigPadding,
                                    (const uint8_t *)[[self getHashBytes:plainText] bytes],
                                    kChosenDigestLength,
                                    (const uint8_t *)[sig bytes],
                                    signedHashBytesSize
                                    );

    return (sanityCheck == noErr) ? YES : NO;
}


- (NSData *) doCipher:(NSData *)plainText key:(NSData *)symmetricKey context:(CCOperation)encryptOrDecrypt padding:(CCOptions *)pkcs7
{
    // Cipher Text container.
    NSData *cipherOrPlainText = nil;
//    NSError *cipherError=nil;

    @try
    {
        CCCryptorStatus ccStatus = kCCSuccess;
        // Symmetric crypto reference.
        CCCryptorRef thisEncipher = NULL;

        // Pointer to output buffer.
        uint8_t *bufferPtr = NULL;
        // Total size of the buffer.
        size_t bufferPtrSize = 0;
        // Remaining bytes to be performed on.
        size_t remainingBytes = 0;
        // Number of bytes moved to buffer.
        size_t movedBytes = 0;
        // Length of plainText buffer.
        size_t plainTextBufferSize = 0;
        // Placeholder for total written.
        size_t totalBytesWritten = 0;
        // A friendly helper pointer.
        uint8_t *ptr;

        // Initialization vector; dummy in this case 0's.
        uint8_t iv[kChosenCipherBlockSize];
        memset( (void *)iv, 0x0, (size_t)sizeof(iv) );

//	LOGGING_FACILITY(plainText != nil, @"PlainText object cannot be nil." );
//	LOGGING_FACILITY(symmetricKey != nil, @"Symmetric key object cannot be nil." );
//	LOGGING_FACILITY(pkcs7 != NULL, @"CCOptions * pkcs7 cannot be NULL." );
////
////
//
//    LOGGING_FACILITY([symmetricKey length] == kChosenCipherKeySize, @"Disjoint choices for key size." );

//
        if ([symmetricKey length] != kChosenCipherKeySize)
        {
            return nil;
        }

        plainTextBufferSize = [plainText length];

//	LOGGING_FACILITY(plainTextBufferSize > 0, @"Empty plaintext passed in." );

        // We don't want to toss padding on if we don't need to
        if (encryptOrDecrypt == kCCEncrypt)
        {
            if (pkcs7 != (CCOptions *)kCCOptionECBMode)
            {
                if ( (plainTextBufferSize % kChosenCipherBlockSize) == 0 )
                {
                    pkcs7 = 0x0000;
                }
                else
                {
                    pkcs7 = (CCOptions *)kCCOptionPKCS7Padding;
                }
            }
        }

//    else if (encryptOrDecrypt != kCCDecrypt) {
//		LOGGING_FACILITY1( 0, @"Invalid CCOperation parameter [%d] for cipher context.", *pkcs7 );
//	}

        // Create and Initialize the crypto reference.
        ccStatus = CCCryptorCreate(     encryptOrDecrypt,
                                        kCCAlgorithmAES128,
                                        (unsigned int)pkcs7,
                                        (const void *)[symmetricKey bytes],
                                        kChosenCipherKeySize,
                                        (const void *)iv,
                                        &thisEncipher
                                        );

//	LOGGING_FACILITY1( ccStatus == kCCSuccess, @"Problem creating the context, ccStatus == %d.", ccStatus );

        // Calculate byte block alignment for all calls through to and including final.
        bufferPtrSize = CCCryptorGetOutputLength(thisEncipher, plainTextBufferSize, true);

        // Allocate buffer.
        bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t) );

        // Zero out buffer.
        memset( (void *)bufferPtr, 0x0, bufferPtrSize );

        // Initialize some necessary book keeping.

        ptr = bufferPtr;

        // Set up initial size.
        remainingBytes = bufferPtrSize;

        // Actually perform the encryption or decryption.
        ccStatus = CCCryptorUpdate( thisEncipher,
                                    (const void *)[plainText bytes],
                                    plainTextBufferSize,
                                    ptr,
                                    remainingBytes,
                                    &movedBytes
                                    );

//	LOGGING_FACILITY1( ccStatus == kCCSuccess, @"Problem with CCCryptorUpdate, ccStatus == %d.", ccStatus );

        // Handle book keeping.
        ptr += movedBytes;
        remainingBytes -= movedBytes;
        totalBytesWritten += movedBytes;

        // Finalize everything to the output buffer.
        ccStatus = CCCryptorFinal(      thisEncipher,
                                        ptr,
                                        remainingBytes,
                                        &movedBytes
                                        );

        totalBytesWritten += movedBytes;

        if (thisEncipher)
        {
            (void)CCCryptorRelease(thisEncipher);
            thisEncipher = NULL;
        }

//	LOGGING_FACILITY1( ccStatus == kCCSuccess, @"Problem with encipherment ccStatus == %d", ccStatus );

        cipherOrPlainText = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)totalBytesWritten];

        if (bufferPtr)
        {
            free(bufferPtr);
        }
    }
    @catch (NSException *exception)
    {
    }

    @finally
    {
        return cipherOrPlainText;

        /*
           Or the corresponding one-shot call:

           ccStatus = CCCrypt(	encryptOrDecrypt,
           kCCAlgorithmAES128,
           typeOfSymmetricOpts,
           (const void *)[self getSymmetricKeyBytes],
           kChosenCipherKeySize,
           iv,
           (const void *) [plainText bytes],
           plainTextBufferSize,
           (void *)bufferPtr,
           bufferPtrSize,
           &movedBytes
           );

         */
    }
}


- (SecKeyRef) getPrivateKeyRef
{
    SecKeyRef privateKeyReference = NULL;

    if (privateKeyRef == NULL)
    {
        if (privateKeyRef == nil)
        {
            BOOL proceed = [self identityAndTrustResult];

            if (!proceed || privateKeyRef == nil)
            {
//
                return nil;
            }
            else
            {
                privateKeyReference = privateKeyRef;
            }
        }
    }
    else
    {
        privateKeyReference = privateKeyRef;
    }

    return privateKeyReference;
}


- (NSData *) getSymmetricKeyBytes
{
    OSStatus sanityCheck = noErr;
    CFDataRef symmetricKeyReturn = nil;

    if (self.symmetricKeyRef == nil)
    {
        NSMutableDictionary *querySymmetricKey = [[NSMutableDictionary alloc] init];

        // Set the private key query dictionary.
        [querySymmetricKey setObject:(__bridge id)kSecClassKey forKey:(__bridge id)kSecClass];
        [querySymmetricKey setObject:symmetricTag forKey:(__bridge id)kSecAttrApplicationTag];
        [querySymmetricKey setObject:[NSNumber numberWithUnsignedInt:CSSM_ALGID_AES] forKey:(__bridge id)kSecAttrKeyType];
        [querySymmetricKey setObject:[NSNumber numberWithBool:YES] forKey:(__bridge id)kSecReturnData];

        // Get the key bits.
        sanityCheck = SecItemCopyMatching( (__bridge CFDictionaryRef)querySymmetricKey, (CFTypeRef *)&symmetricKeyReturn );

        if (sanityCheck == noErr && symmetricKeyReturn != nil)
        {
            self.symmetricKeyRef = (__bridge_transfer NSData *)symmetricKeyReturn;
        }
        else
        {
            self.symmetricKeyRef = nil;
        }
    }
    else
    {
        symmetricKeyReturn = (__bridge CFDataRef)self.symmetricKeyRef;
    }

    return (__bridge_transfer NSData *)symmetricKeyReturn;
}


- (CFTypeRef) getPersistentKeyRefWithKeyRef:(SecKeyRef)keyRef
{
    OSStatus sanityCheck = noErr;
    CFTypeRef persistentRef = NULL;

    LOGGING_FACILITY(keyRef != NULL, @"keyRef object cannot be NULL." );

    NSMutableDictionary *queryKey = [[NSMutableDictionary alloc] init];

    // Set the PersistentKeyRef key query dictionary.
    [queryKey setObject:(__bridge id)keyRef forKey:(__bridge id)kSecValueRef];
    [queryKey setObject:[NSNumber numberWithBool:YES] forKey:(__bridge id)kSecReturnPersistentRef];

    // Get the persistent key reference.
    sanityCheck = SecItemCopyMatching( (__bridge CFDictionaryRef)queryKey, (CFTypeRef *)&persistentRef );

    if (sanityCheck != noErr)
    {
        @throw @"Error coppying persistent Ref";
    }

    return persistentRef;
}


- (SecKeyRef) getKeyRefWithPersistentKeyRef:(CFTypeRef)persistentRef
{
    OSStatus sanityCheck = noErr;
    SecKeyRef keyRef = NULL;

    LOGGING_FACILITY(persistentRef != NULL, @"persistentRef object cannot be NULL." );

    NSMutableDictionary *queryKey = [[NSMutableDictionary alloc] init];

    // Set the SecKeyRef query dictionary.
    [queryKey setObject:(__bridge id)persistentRef forKey:(__bridge id)kSecValuePersistentRef];
    [queryKey setObject:[NSNumber numberWithBool:YES] forKey:(__bridge id)kSecReturnRef];

    // Get the persistent key reference.
    sanityCheck = SecItemCopyMatching( (__bridge CFDictionaryRef)queryKey, (CFTypeRef *)&keyRef );
    if (sanityCheck != noErr)
    {
        @throw @"Error getting key Ref";
    }

    return keyRef;
}


- (SecKeyRef) getPublicKeyRef
{
    SecKeyRef publicKeyReference = NULL;

    if (publicKeyRef == NULL)
    {
        if (publicKeyRef == nil)
        {
            BOOL proceed = [self identityAndTrustResult];

            if (!proceed || publicKeyRef == nil)
            {
                @throw @"was not able to verify security information";
                return nil;
            }
            else
            {
                publicKeyReference = publicKeyRef;
            }
        }
    }
    else
    {
        publicKeyReference = publicKeyRef;
    }

    return publicKeyReference;
}


//#endif

@end
