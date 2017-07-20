//
//  NatVolume.h
//
//  Created by huangyake on 17/1/7.
//  Copyright © 2017 Instapp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NatVolume : NSObject
typedef void (^NatCallback)(id error,id result);
+ (id)singletonManger;
- (void)get:(NatCallback)callback;
- (void)set:(NSNumber *)volume :(NatCallback)callback;

@end
