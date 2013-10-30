//
//  OMGLabel.h
//  OMGLabel
//
//  Created by Anton on 25.10.13.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>
#import <CoreText/CoreText.h>
#import "OMGLabelSettings.h"

typedef enum OMGLabelTextAlignment{
    OMGLabelTextAlignmentLeft = 3,
    OMGLabelTextAlignmentRight,
    OMGLabelTextAlignmentMiddle
}OMGLabelTextAlignment;

typedef enum OMGLabelTextVerticalAlignment{
    OMGLabelTextVerticalAlignmentTop = 7,
    OMGLabelTextVerticalAlignmentMiddle,
    OMGLabelTextVerticalAlignmentBottom
}OMGLabelTextVerticalAlignment;

@interface OMGLabel : UILabel

@property (nonatomic, strong) NSArray *gradientColors;

@property (nonatomic, strong) UIColor *shadowColor;
@property (nonatomic, assign) CGSize shadowOffset;
@property (nonatomic, assign) CGFloat shadowBlur;
@property (nonatomic, assign) BOOL shadow;

@property (nonatomic, strong) UIColor *strokeColor;
@property (nonatomic, assign) CGFloat strokeWidth;
@property (nonatomic, assign) BOOL stroke;

@property (nonatomic, assign) UIColor *fillColor;

@property (nonatomic, assign) CGFloat kern;
@property (nonatomic, assign) CGFloat lineSpacing;
@property (nonatomic, assign) OMGLabelTextAlignment tAlignment;
@property (nonatomic, assign) OMGLabelTextVerticalAlignment vAlignment;

@property (nonatomic, strong) OMGLabelSettings *settings;

@end
