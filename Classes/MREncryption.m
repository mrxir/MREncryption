//
//  MREncryption.m
//  MREncryption
//
//  Created by MrXir on 2017/9/15.
//  Copyright © 2017年 MRXIR Inc. All rights reserved.
//

#import "MREncryption.h"

@implementation MREncryption

+ (NSString*)doSKCipher:(NSString*)plainText
                    enc:(CCOperation)encryptOrDecrypt
                    key:(NSString *)keyInput
                     iv:(NSString *)ivInput
{
    
    const void *vplainText;
    size_t plainTextBufferSize;
    
    //变成nsdata
    NSData *decodedKey = [[NSData alloc] initWithBase64EncodedString:keyInput options:0];
    //NSData *decodedIv = [[NSData alloc] initWithBase64EncodedString:ivInput options:0];
    
    if (encryptOrDecrypt == kCCDecrypt) {
        NSData *EncryptData = [[NSData alloc] initWithBase64EncodedString:plainText options:0];
        plainTextBufferSize = [EncryptData length];
        vplainText = [EncryptData bytes];
    } else {
        plainTextBufferSize = [plainText length];
        vplainText = (const void *) [plainText UTF8String];
    }
    
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    //  uint8_t ivkCCBlockSize3DES;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    unsigned char result1[8];
    memcpy(result1, decodedKey.bytes, decodedKey.length);
    
    ccStatus = CCCrypt(encryptOrDecrypt,
                       kCCAlgorithmDES,
                       kCCOptionPKCS7Padding,
                       keyInput.UTF8String,
                       kCCKeySizeDES,
                       keyInput.UTF8String,
                       vplainText,
                       plainTextBufferSize,
                       bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
    
    //if (ccStatus == kCCSuccess) NSLog(@"SUCCESS");
    /*else*/ if (ccStatus == kCCParamError) return @"PARAM ERROR";
    else if (ccStatus == kCCBufferTooSmall) return @"BUFFER TOO SMALL";
    else if (ccStatus == kCCMemoryFailure) return @"MEMORY FAILURE";
    else if (ccStatus == kCCAlignmentError) return @"ALIGNMENT";
    else if (ccStatus == kCCDecodeError) return @"DECODE ERROR";
    else if (ccStatus == kCCUnimplemented) return @"UNIMPLEMENTED";
    
    NSString *result;
    
    if (encryptOrDecrypt == kCCDecrypt) {
        result = [ [NSString alloc] initWithData: [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes] encoding:NSUTF8StringEncoding];
    } else {
        NSData *myData = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
        result = [myData base64EncodedStringWithOptions:0];
        
    }
    return result;
}

@end
