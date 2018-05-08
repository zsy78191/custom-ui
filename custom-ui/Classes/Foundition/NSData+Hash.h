//
//  NSData+Hash.h
//  customui-dev
//
//  Created by 张超 on 2018/1/23.
//  Copyright © 2018年 orzer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Hash)
- (NSString *)md2String ;
- (NSData *)md2Data ;
- (NSString *)md4String ;
- (NSData *)md4Data ;
- (NSString *)md5String ;
- (NSData *)md5Data ;
- (NSString *)sha1String ;
- (NSData *)sha1Data ;
- (NSString *)sha224String ;
- (NSData *)sha224Data ;
- (NSString *)sha256String ;
- (NSData *)sha256Data ;
- (NSString *)sha384String ;
- (NSData *)sha384Data ;
- (NSString *)sha512String ;
- (NSData *)sha512Data ;
@end
