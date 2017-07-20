//
//  NatVolume.m
//
//  Created by huangyake on 17/1/7.
//  Copyright © 2017 Instapp. All rights reserved.
//


#import "NatVolume.h"
#import <MediaPlayer/MediaPlayer.h> 

@implementation NatVolume

+ (id)singletonManger{
    static id manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}


- (void)get:(NatCallback)callback{
     CGFloat volume =  [NatVolume getSystemVolumValue];
    callback(nil,@{@"volume":@(volume)});
}

- (void)set:(NSNumber *)volume :(NatCallback)callback{
    if ([volume isKindOfClass:[NSNumber class]] && [volume floatValue] > 0) {
        [NatVolume getSystemVolumSlider].value = [volume floatValue];
        callback(nil,@{@"volume":@([volume floatValue])});
    }else{
        callback(@{@"error":@{@"code":@1,@"msg":@""}},nil);
    }
}
+(UISlider*)getSystemVolumSlider{
    static UISlider * volumeViewSlider = nil;
    if (volumeViewSlider == nil) {
        MPVolumeView *volumeView = [[MPVolumeView alloc] initWithFrame:CGRectMake(10, 50, 200, 4)];
        volumeView.hidden = YES;
        for (UIView* newView in volumeView.subviews) {
            if ([newView.class.description isEqualToString:@"MPVolumeSlider"]){
                volumeViewSlider = (UISlider*)newView;
                break;
            }
        }
    }
    
    return volumeViewSlider;
}


/*
 *获取系统音量大小
 */
+(CGFloat)getSystemVolumValue{
    return [[self getSystemVolumSlider] value];
}
/*
 *设置系统音量大小
 */
+(void)setSysVolumWith:(double)value{
    [self getSystemVolumSlider].value = value;
}

@end
