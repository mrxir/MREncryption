//
//  ViewController.m
//  MREncryption
//
//  Created by MrXir on 2017/9/15.
//  Copyright © 2017年 MRXIR Inc. All rights reserved.
//

#import "ViewController.h"

#import "MREncryption.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"参考文章: https://my.oschina.net/jsan/blog/54385");
    
    NSString *text = @"😡JJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJ☆o☆)／JJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJ{}{【\r\n\tDES是对称性加密里面常见一种，全称为Data Encryption Standard，即数据加密标准，是一种使用密钥加密的块算法。密钥长度是64位(bit)，超过位数密钥被忽略。所谓对称性加密，加密和解密密钥相同。对称性加密一般会按照固定长度，把待加密字符串分成块。不足一整块或者刚好最后有特殊填充字符。往往跨语言做DES加密解密，经常会出现问题。往往是填充方式不对、或者编码不一致、或者选择加密解密模式(ECB,CBC,CTR,OFB,CFB,NCFB,NOFB)没有对应上造成。常见的填充模式有： 'pkcs5','pkcs7','iso10126','ansix923','zero' 类型，包括DES-ECB,DES-CBC,DES-CTR,DES-OFB,DES-CFB。作为IT人，你可以通过该工具测试DES加密解密！有问题欢迎与我联系！\r\n\t】}{}JJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJ🎾🎾🎱JJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJaofijepfjopajdfa;osfJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJ🏈🎾🎾🎱🎱🎽😏☺️😅😠😠😠😘＼(☆o☆)／＼(☆o☆)／٩(●˙▿˙●)۶…⋆ฺ˚‧*♡ॢ˃̶̤̀◡˂̶̤́♡ॢ*‧˚(*^o^*)😵😷😷😷😷😡JJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJasdfasf3ERFJWGFUI38EUF3Y12934UR014U  198231 1skdfjh 啊速度发货顾没法拍UY）*Y)Y$@TU F阿三地方好i额哈佛士大夫都7日34ugu'm'f 0-32 9812983R OQEFO WO8E|||😡";
    
    NSLog(@"原文: %@", text);
    
    NSString *encodedString = [text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"原文转码后: %@", encodedString);
    
    NSString *base64Key = @"ABCDEFGH";
    NSLog(@"密码: %@", base64Key);
    
    NSString *iv = base64Key;
    NSLog(@"向量: %@", iv);
    
    NSString *encoded = [MREncryption doSKCipher:encodedString enc:kCCEncrypt key:base64Key iv:iv];
    NSLog(@"加密后: %@", encoded);
    
    NSString * decoded =  [MREncryption doSKCipher:encoded enc:kCCDecrypt key:base64Key iv:iv];
    NSLog(@"解密后: %@", decoded);
    
    decoded = [decoded stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"解码后: %@", decoded);
    
    BOOL equal = [decoded isEqualToString:text];
    
    NSLog(@"解密且解码后是否与原文一致 %d", equal);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
