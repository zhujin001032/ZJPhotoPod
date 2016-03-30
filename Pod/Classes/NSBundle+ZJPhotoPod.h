//
//  NSBundle+ZJPhotoPod.h
//  Pods
//
//  Created by 何助金 on 16/3/18.
//
//

#import <Foundation/Foundation.h>

@interface NSBundle (ZJPhotoPod)
+(NSBundle *)zjp_mainBundle;
+(NSBundle *)zjp_resourcesBundle;
+(NSString *)zjp_localizedStringForKey:(NSString *)key;
@end
