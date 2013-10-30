//
//  OMGLabelSettings.m
//  OMGLabel
//
//  Created by Anton on 29.10.13.
//

#import "OMGLabelSettings.h"

@implementation OMGLabelSettings

- (id)init
{
    self = [super init];
    if (self) {
        _settings = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)addSettings:(NSDictionary *)settings{
    [_settings addEntriesFromDictionary:settings];
}

@end
