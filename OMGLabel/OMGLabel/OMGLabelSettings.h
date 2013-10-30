//
//  OMGLabelSettings.h
//  OMGLabel
//
//  Created by Anton on 29.10.13.
//

#import <Foundation/Foundation.h>

typedef enum OMGLabelSettingsType{
    OMGLabelSettingsLineSpacing = 17,
    OMGLabelSettingsShadow,
    OMGLabelSettingsShadowColor,
    OMGLabelSettingsShadowBlur,
    OMGLabelSettingsShadowOffset,
    OMGLabelSettingsStroke,
    OMGLabelSettingsStrokeColor,
    OMGLabelSettingsStrokeWidth,
    OMGLabelSettingsFillColor,
    OMGLabelSettingsTextAlignment,
    OMGLabelSettingsGradientColors
}OMGLabelSettingsType;

@interface OMGLabelSettings : NSObject

@property (nonatomic, strong, readonly) NSMutableDictionary *settings;

- (void)addSettings:(NSDictionary *)settings;

@end
