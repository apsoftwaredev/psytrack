/*
 
 File: SecKeyWrapper.m
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

#import "SecKeyWrapper.h"
#import <Security/Security.h>

@implementation SecKeyWrapper

@synthesize publicTag, privateTag, symmetricTag, symmetricKeyRef;

#if DEBUG
	#define LOGGING_FACILITY(X, Y)	\
					NSAssert(X, Y);	

	#define LOGGING_FACILITY1(X, Y, Z)	\
					NSAssert1(X, Y, Z);	
#else
	#define LOGGING_FACILITY(X, Y)	\
				if (!(X)) {			\
					NSLog(Y);		\
				}					

	#define LOGGING_FACILITY1(X, Y, Z)	\
				if (!(X)) {				\
					NSLog(Y, Z);		\
				}						
#endif

#if TARGET_IPHONE_SIMULATOR

// Dummy implementations for no-building simulator target (reduce compiler warnings)
+ (SecKeyWrapper *)sharedWrapper { return nil; }
- (void)setObject:(id)inObject forKey:(id)key {}
- (id)objectForKey:(id)key { return nil; }
// Dummy implementations for my SecKeyWrapper class.
- (void)generateKeyPair:(NSUInteger)keySize {}
- (void)deleteAsymmetricKeys {}
- (void)deleteSymmetricKey {}
- (void)generateSymmetricKey {}
- (NSData *)getSymmetricKeyBytes { return NULL; }
- (SecKeyRef)addPeerPublicKey:(NSString *)peerName keyBits:(NSData *)publicKey { return NULL; }
- (void)removePeerPublicKey:(NSString *)peerName {}
- (NSData *)wrapSymmetricKey:(NSData *)symmetricKey keyRef:(SecKeyRef)publicKey { return nil; }
- (NSData *)unwrapSymmetricKey:(NSData *)wrappedSymmetricKey { return nil; }
- (NSData *)getSignatureBytes:(NSData *)plainText { return nil; }
- (NSData *)getHashBytes:(NSData *)plainText { return nil; }
- (BOOL)verifySignature:(NSData *)plainText secKeyRef:(SecKeyRef)publicKey signature:(NSData *)sig { return NO; }
- (NSData *)doCipher:(NSData *)plainText key:(NSData *)symmetricKey context:(CCOperation)encryptOrDecrypt padding:(CCOptions *)pkcs7 { return nil; } 
- (SecKeyRef)getPublicKeyRef { return nil; }
- (NSData *)getPublicKeyBits { return nil; }
- (SecKeyRef)getPrivateKeyRef { return nil; }
- (CFTypeRef)getPersistentKeyRefWithKeyRef:(SecKeyRef)keyRef { return NULL; }
- (SecKeyRef)getKeyRefWithPersistentKeyRef:(CFTypeRef)persistentRef { return NULL; }
#else

// (See cssmtype.h and cssmapple.h on the Mac OS X SDK.)

enum {
	CSSM_ALGID_NONE =					0x00000000L,
	CSSM_ALGID_VENDOR_DEFINED =			CSSM_ALGID_NONE + 0x80000000L,
	CSSM_ALGID_AES
};

// identifiers used to find public, private, and symmetric key.
static const uint8_t publicKeyIdentifier[]		= kPublicKeyTag;
static const uint8_t privateKeyIdentifier[]		= kPrivateKeyTag;
static const uint8_t symmetricKeyIdentifier[]	= kSymmetricKeyTag;

static SecKeyWrapper * __sharedKeyWrapper = nil;

/* Begin method definitions */

+ (SecKeyWrapper *)sharedWrapper {
    @synchronized(self) {
        if (__sharedKeyWrapper == nil) {
            [[self alloc] init];
        }
    }
    return __sharedKeyWrapper;
}

+ (id)allocWithZone:(NSZone *)zone {
    @synchronized(self) {
        if (__sharedKeyWrapper == nil) {
            __sharedKeyWrapper = [super allocWithZone:zone];
            return __sharedKeyWrapper;
        }
    }
    return nil;
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}


- (NSUInteger)retainCount {
    return UINT_MAX;
}

-(id)init {
	 if (self = [super init])
	 {
		 // Tag data to search for keys.
		 privateTag = [[NSData alloc] initWithBytes:privateKeyIdentifier length:sizeof(privateKeyIdentifier)];
		 publicTag = [[NSData alloc] initWithBytes:publicKeyIdentifier length:sizeof(publicKeyIdentifier)];
		 symmetricTag = [[NSData alloc] initWithBytes:symmetricKeyIdentifier length:sizeof(symmetricKeyIdentifier)];
	 }
	
	return self;
}

- (NSData *)wrapSymmetricKey:(NSData *)symmetricKey keyRef:(SecKeyRef)publicKey {
	OSStatus sanityCheck = noErr;
	size_t cipherBufferSize = 0;
	size_t keyBufferSize = 0;
	
	LOGGING_FACILITY( symmetricKey != nil, @"Symmetric key parameter is nil." );
	LOGGING_FACILITY( publicKey != nil, @"Key parameter is nil." );
	
	NSData * cipher = nil;
	uint8_t * cipherBuffer = NULL;
	
	// Calculate the buffer sizes.
	cipherBufferSize = SecKeyGetBlockSize(publicKey);
	keyBufferSize = [symmetricKey length];
	
	if (kTypeOfWrapPadding == kSecPaddingNone) {
		LOGGING_FACILITY( keyBufferSize <= cipherBufferSize, @"Nonce integer is too large and falls outside multiplicative group." );
	} else {
		LOGGING_FACILITY( keyBufferSize <= (cipherBufferSize - 11), @"Nonce integer is too large and falls outside multiplicative group." );
	}
	
	// Allocate some buffer space. I don't trust calloc.
	cipherBuffer = malloc( cipherBufferSize * sizeof(uint8_t) );
	memset((void *)cipherBuffer, 0x0, cipherBufferSize);
	
	// Encrypt using the public key.
	sanityCheck = SecKeyEncrypt(	publicKey,
									kTypeOfWrapPadding,
									(const uint8_t *)[symmetricKey bytes],
									keyBufferSize,
									cipherBuffer,
									&cipherBufferSize
								);
	
	LOGGING_FACILITY1( sanityCheck == noErr, @"Error encrypting, OSStatus == %d.", sanityCheck );
	
	// Build up cipher text blob.
	cipher = [NSData dataWithBytes:(const void *)cipherBuffer length:(NSUInteger)cipherBufferSize];
	
	if (cipherBuffer) free(cipherBuffer);
	
	return cipher;
}

- (NSData *)unwrapSymmetricKey:(NSData *)wrappedSymmetricKey {
	OSStatus sanityCheck = noErr;
	size_t cipherBufferSize = 0;
	size_t keyBufferSize = 0;
	
	NSData * key = nil;
	uint8_t * keyBuffer = NULL;
	
	SecKeyRef privateKey = NULL;
	
	privateKey = [self getPrivateKeyRef];
	LOGGING_FACILITY( privateKey != NULL, @"No private key found in the keychain." );
	
	// Calculate the buffer sizes.
	cipherBufferSize = SecKeyGetBlockSize(privateKey);
	keyBufferSize = [wrappedSymmetricKey length];
	
	LOGGING_FACILITY( keyBufferSize <= cipherBufferSize, @"Encrypted nonce is too large and falls outside multiplicative group." );
	
	// Allocate some buffer space. I don't trust calloc.
	keyBuffer = malloc( keyBufferSize * sizeof(uint8_t) );
	memset((void *)keyBuffer, 0x0, keyBufferSize);
	
	// Decrypt using the private key.
	sanityCheck = SecKeyDecrypt(	privateKey,
									kTypeOfWrapPadding,
									(const uint8_t *) [wrappedSymmetricKey bytes],
									cipherBufferSize,
									keyBuffer,
									&keyBufferSize
								);
	
	LOGGING_FACILITY1( sanityCheck == noErr, @"Error decrypting, OSStatus == %d.", sanityCheck );
	
	// Build up plain text blob.
	key = [NSData dataWithBytes:(const void *)keyBuffer length:(NSUInteger)keyBufferSize];
	
	if (keyBuffer) free(keyBuffer);
	
	return key;
}

- (NSData *)getHashBytes:(NSData *)plainText {
	CC_SHA1_CTX ctx;
	uint8_t * hashBytes = NULL;
	NSData * hash = nil;
	
	// Malloc a buffer to hold hash.
	hashBytes = malloc( kChosenDigestLength * sizeof(uint8_t) );
	memset((void *)hashBytes, 0x0, kChosenDigestLength);
	
	// Initialize the context.
	CC_SHA1_Init(&ctx);
	// Perform the hash.
	CC_SHA1_Update(&ctx, (void *)[plainText bytes], [plainText length]);
	// Finalize the output.
	CC_SHA1_Final(hashBytes, &ctx);
	
	// Build up the SHA1 blob.
	hash = [NSData dataWithBytes:(const void *)hashBytes length:(NSUInteger)kChosenDigestLength];
	
	if (hashBytes) free(hashBytes);
	
	return hash;
}

- (NSData *)getSignatureBytes:(NSData *)plainText {
	OSStatus sanityCheck = noErr;
	NSData * signedHash = nil;
	
	uint8_t * signedHashBytes = NULL;
	size_t signedHashBytesSize = 0;
	
	SecKeyRef privateKey = NULL;
	
	privateKey = [self getPrivateKeyRef];
	signedHashBytesSize = SecKeyGetBlockSize(privateKey);
	
	// Malloc a buffer to hold signature.
	signedHashBytes = malloc( signedHashBytesSize * sizeof(uint8_t) );
	memset((void *)signedHashBytes, 0x0, signedHashBytesSize);
	
	// Sign the SHA1 hash.
	sanityCheck = SecKeyRawSign(	privateKey, 
									kTypeOfSigPadding, 
									(const uint8_t *)[[self getHashBytes:plainText] bytes], 
									kChosenDigestLength, 
									(uint8_t *)signedHashBytes, 
									&signedHashBytesSize
								);
	
	LOGGING_FACILITY1( sanityCheck == noErr, @"Problem signing the SHA1 hash, OSStatus == %d.", sanityCheck );
	
	// Build up signed SHA1 blob.
	signedHash = [NSData dataWithBytes:(const void *)signedHashBytes length:(NSUInteger)signedHashBytesSize];
	
	if (signedHashBytes) free(signedHashBytes);
	
	return signedHash;
}

- (BOOL)verifySignature:(NSData *)plainText secKeyRef:(SecKeyRef)publicKey signature:(NSData *)sig {
	size_t signedHashBytesSize = 0;
	OSStatus sanityCheck = noErr;
	
	// Get the size of the assymetric block.
	signedHashBytesSize = SecKeyGetBlockSize(publicKey);
	
	sanityCheck = SecKeyRawVerify(	publicKey, 
									kTypeOfSigPadding, 
									(const uint8_t *)[[self getHashBytes:plainText] bytes],
									kChosenDigestLength, 
									(const uint8_t *)[sig bytes],
									signedHashBytesSize
								  );
	
	return (sanityCheck == noErr) ? YES : NO;
}

- (NSData *)doCipher:(NSData *)plainText key:(NSData *)symmetricKey context:(CCOperation)encryptOrDecrypt padding:(CCOptions *)pkcs7 {
	CCCryptorStatus ccStatus = kCCSuccess;
	// Symmetric crypto reference.
	CCCryptorRef thisEncipher = NULL;
	// Cipher Text container.
	NSData * cipherOrPlainText = nil;
	// Pointer to output buffer.
	uint8_t * bufferPtr = NULL;
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
	uint8_t * ptr;
	
	// Initialization vector; dummy in this case 0's.
	uint8_t iv[kChosenCipherBlockSize];
	memset((void *) iv, 0x0, (size_t) sizeof(iv));
	
	LOGGING_FACILITY(plainText != nil, @"PlainText object cannot be nil." );
	LOGGING_FACILITY(symmetricKey != nil, @"Symmetric key object cannot be nil." );
	LOGGING_FACILITY(pkcs7 != NULL, @"CCOptions * pkcs7 cannot be NULL." );
	LOGGING_FACILITY([symmetricKey length] == kChosenCipherKeySize, @"Disjoint choices for key size." );
			 
	plainTextBufferSize = [plainText length];
	
	LOGGING_FACILITY(plainTextBufferSize > 0, @"Empty plaintext passed in." );
	
	// We don't want to toss padding on if we don't need to
	if (encryptOrDecrypt == kCCEncrypt) {
		if (*pkcs7 != kCCOptionECBMode) {
			if ((plainTextBufferSize % kChosenCipherBlockSize) == 0) {
				*pkcs7 = 0x0000;
			} else {
				*pkcs7 = kCCOptionPKCS7Padding;
			}
		}
	} else if (encryptOrDecrypt != kCCDecrypt) {
		LOGGING_FACILITY1( 0, @"Invalid CCOperation parameter [%d] for cipher context.", *pkcs7 );
	} 
	
	// Create and Initialize the crypto reference.
	ccStatus = CCCryptorCreate(	encryptOrDecrypt, 
								kCCAlgorithmAES128, 
								*pkcs7, 
								(const void *)[symmetricKey bytes], 
								kChosenCipherKeySize, 
								(const void *)iv, 
								&thisEncipher
							);
	
	LOGGING_FACILITY1( ccStatus == kCCSuccess, @"Problem creating the context, ccStatus == %d.", ccStatus );
	
	// Calculate byte block alignment for all calls through to and including final.
	bufferPtrSize = CCCryptorGetOutputLength(thisEncipher, plainTextBufferSize, true);
	
	// Allocate buffer.
	bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t) );
	
	// Zero out buffer.
	memset((void *)bufferPtr, 0x0, bufferPtrSize);
	
	// Initialize some necessary book keeping.
	
	ptr = bufferPtr;
	
	// Set up initial size.
	remainingBytes = bufferPtrSize;
	
	// Actually perform the encryption or decryption.
	ccStatus = CCCryptorUpdate( thisEncipher,
								(const void *) [plainText bytes],
								plainTextBufferSize,
								ptr,
								remainingBytes,
								&movedBytes
							);
	
	LOGGING_FACILITY1( ccStatus == kCCSuccess, @"Problem with CCCryptorUpdate, ccStatus == %d.", ccStatus );
	
	// Handle book keeping.
	ptr += movedBytes;
	remainingBytes -= movedBytes;
	totalBytesWritten += movedBytes;
	
	// Finalize everything to the output buffer.
	ccStatus = CCCryptorFinal(	thisEncipher,
								ptr,
								remainingBytes,
								&movedBytes
							);
	
	totalBytesWritten += movedBytes;
	
	if (thisEncipher) {
		(void) CCCryptorRelease(thisEncipher);
		thisEncipher = NULL;
	}
	
	LOGGING_FACILITY1( ccStatus == kCCSuccess, @"Problem with encipherment ccStatus == %d", ccStatus );
	
	cipherOrPlainText = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)totalBytesWritten];

	if (bufferPtr) free(bufferPtr);
	
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

- (SecKeyRef)getPublicKeyRef {
	OSStatus sanityCheck = noErr;
	SecKeyRef publicKeyReference = NULL;
	
	if (publicKeyRef == NULL) {
		NSMutableDictionary * queryPublicKey = [[NSMutableDictionary alloc] init];
		
		// Set the public key query dictionary.
		[queryPublicKey setObject:(id)kSecClassKey forKey:(id)kSecClass];
		[queryPublicKey setObject:publicTag forKey:(id)kSecAttrApplicationTag];
		[queryPublicKey setObject:(id)kSecAttrKeyTypeRSA forKey:(id)kSecAttrKeyType];
		[queryPublicKey setObject:[NSNumber numberWithBool:YES] forKey:(id)kSecReturnRef];
		
		// Get the key.
		sanityCheck = SecItemCopyMatching((CFDictionaryRef)queryPublicKey, (CFTypeRef *)&publicKeyReference);
		
		if (sanityCheck != noErr)
		{
			publicKeyReference = NULL;
		}
		
		[queryPublicKey release];
	} else {
		publicKeyReference = publicKeyRef;
	}
	
	return publicKeyReference;
}

- (NSData *)getPublicKeyBits {
	OSStatus sanityCheck = noErr;
	NSData * publicKeyBits = nil;
	
	NSMutableDictionary * queryPublicKey = [[NSMutableDictionary alloc] init];
		
	// Set the public key query dictionary.
	[queryPublicKey setObject:(id)kSecClassKey forKey:(id)kSecClass];
	[queryPublicKey setObject:publicTag forKey:(id)kSecAttrApplicationTag];
	[queryPublicKey setObject:(id)kSecAttrKeyTypeRSA forKey:(id)kSecAttrKeyType];
	[queryPublicKey setObject:[NSNumber numberWithBool:YES] forKey:(id)kSecReturnData];
		
	// Get the key bits.
	sanityCheck = SecItemCopyMatching((CFDictionaryRef)queryPublicKey, (CFTypeRef *)&publicKeyBits);
		
	if (sanityCheck != noErr)
	{
		publicKeyBits = nil;
	}
		
	[queryPublicKey release];
	
	return publicKeyBits;
}

- (SecKeyRef)getPrivateKeyRef {
	OSStatus sanityCheck = noErr;
	SecKeyRef privateKeyReference = NULL;
	
	if (privateKeyRef == NULL) {
		NSMutableDictionary * queryPrivateKey = [[NSMutableDictionary alloc] init];
		
		// Set the private key query dictionary.
		[queryPrivateKey setObject:(id)kSecClassKey forKey:(id)kSecClass];
		[queryPrivateKey setObject:privateTag forKey:(id)kSecAttrApplicationTag];
		[queryPrivateKey setObject:(id)kSecAttrKeyTypeRSA forKey:(id)kSecAttrKeyType];
		[queryPrivateKey setObject:[NSNumber numberWithBool:YES] forKey:(id)kSecReturnRef];
		
		// Get the key.
		sanityCheck = SecItemCopyMatching((CFDictionaryRef)queryPrivateKey, (CFTypeRef *)&privateKeyReference);
		
		if (sanityCheck != noErr)
		{
			privateKeyReference = NULL;
		}
		
		[queryPrivateKey release];
	} else {
		privateKeyReference = privateKeyRef;
	}
	
	return privateKeyReference;
}

- (NSData *)getSymmetricKeyBytes {
	OSStatus sanityCheck = noErr;
	NSData * symmetricKeyReturn = nil;
	
	if (self.symmetricKeyRef == nil) {
		NSMutableDictionary * querySymmetricKey = [[NSMutableDictionary alloc] init];
		
		// Set the private key query dictionary.
		[querySymmetricKey setObject:(id)kSecClassKey forKey:(id)kSecClass];
		[querySymmetricKey setObject:symmetricTag forKey:(id)kSecAttrApplicationTag];
		[querySymmetricKey setObject:[NSNumber numberWithUnsignedInt:CSSM_ALGID_AES] forKey:(id)kSecAttrKeyType];
		[querySymmetricKey setObject:[NSNumber numberWithBool:YES] forKey:(id)kSecReturnData];
		
		// Get the key bits.
		sanityCheck = SecItemCopyMatching((CFDictionaryRef)querySymmetricKey, (CFTypeRef *)&symmetricKeyReturn);
		
		if (sanityCheck == noErr && symmetricKeyReturn != nil) {
			self.symmetricKeyRef = symmetricKeyReturn;
		} else {
			self.symmetricKeyRef = nil;
		}
		
		[querySymmetricKey release];
	} else {
		symmetricKeyReturn = self.symmetricKeyRef;
	}

	return symmetricKeyReturn;
}

- (CFTypeRef)getPersistentKeyRefWithKeyRef:(SecKeyRef)keyRef {
	OSStatus sanityCheck = noErr;
	CFTypeRef persistentRef = NULL;
	
	LOGGING_FACILITY(keyRef != NULL, @"keyRef object cannot be NULL." );
	
	NSMutableDictionary * queryKey = [[NSMutableDictionary alloc] init];
	
	// Set the PersistentKeyRef key query dictionary.
	[queryKey setObject:(id)keyRef forKey:(id)kSecValueRef];
	[queryKey setObject:[NSNumber numberWithBool:YES] forKey:(id)kSecReturnPersistentRef];
	
	// Get the persistent key reference.
	sanityCheck = SecItemCopyMatching((CFDictionaryRef)queryKey, (CFTypeRef *)&persistentRef);
	[queryKey release];
	
	return persistentRef;
}

- (SecKeyRef)getKeyRefWithPersistentKeyRef:(CFTypeRef)persistentRef {
	OSStatus sanityCheck = noErr;
	SecKeyRef keyRef = NULL;
	
	LOGGING_FACILITY(persistentRef != NULL, @"persistentRef object cannot be NULL." );
	
	NSMutableDictionary * queryKey = [[NSMutableDictionary alloc] init];
	
	// Set the SecKeyRef query dictionary.
	[queryKey setObject:(id)persistentRef forKey:(id)kSecValuePersistentRef];
	[queryKey setObject:[NSNumber numberWithBool:YES] forKey:(id)kSecReturnRef];
	
	// Get the persistent key reference.
	sanityCheck = SecItemCopyMatching((CFDictionaryRef)queryKey, (CFTypeRef *)&keyRef);
	[queryKey release];
	
	return keyRef;
}

- (void)dealloc {
    [privateTag release];
    [publicTag release];
	[symmetricTag release];
	[symmetricKeyRef release];
	if (publicKeyRef) CFRelease(publicKeyRef);
	if (privateKeyRef) CFRelease(privateKeyRef);
    [super dealloc];
}

#endif

@end
