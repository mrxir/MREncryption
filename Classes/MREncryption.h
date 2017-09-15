//
//  MREncryption.h
//  MREncryption
//
//  Created by MrXir on 2017/9/15.
//  Copyright © 2017年 MRXIR Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCrypto.h>

@interface MREncryption : NSObject

+ (NSString*)doSKCipher:(NSString*)plainText
                    enc:(CCOperation)encryptOrDecrypt
                    key:(NSString *)keyInput
                     iv:(NSString *)ivInput;

@end
