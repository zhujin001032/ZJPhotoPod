//
//  NSBundle+ZJPhotoPod.m
//  Pods
//
//  Created by 何助金 on 16/3/18.
//
//

#import "NSBundle+ZJPhotoPod.h"
#import "ZJTakePhotoActionSheet.h"

@implementation NSBundle (ZJPhotoPod)
+(NSBundle *)zjp_mainBundle{
    return  [NSBundle bundleForClass:[ZJTakePhotoActionSheet class]];
}
+(NSBundle *)zjp_resourcesBundle{
    NSBundle *mainBundle = [NSBundle zjp_mainBundle];
    return [NSBundle bundleWithPath:[mainBundle pathForResource:@"ZJPhotoPod" ofType:@"bundle"]];
}

+(NSString *)zjp_localizedStringForKey:(NSString *)key{
    return NSLocalizedStringFromTableInBundle(key, @"ZJPhotoPod", [NSBundle zjp_resourcesBundle], nil);
}
@end
