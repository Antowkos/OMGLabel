//
//  OMGLabel.m
//  OMGLabel
//
//  Created by Anton on 25.10.13.
//  

#import "OMGLabel.h"
#import "UIColor-Expanded.h"

@interface OMGLabel ()

@property (nonatomic, assign) BOOL alignmentSet;
@property (nonatomic, assign) BOOL useSettings;

@end

@implementation OMGLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.tAlignment = OMGLabelTextAlignmentLeft;
        self.vAlignment = OMGLabelTextVerticalAlignmentTop;
        self.lineSpacing = 0.0f;
        
        self.strokeColor = [UIColor grayColor];
        self.strokeWidth = 1.0f;
        self.stroke = YES;
        
        self.shadowColor = [UIColor grayColor];
        self.shadowOffset = CGSizeMake(1, 1);
        self.shadowBlur = 1.0f;
        self.shadow = YES;
        
        self.fillColor = [UIColor whiteColor];
        
        self.useSettings = NO;
        self.kern = 0.0f;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef X = UIGraphicsGetCurrentContext();
	
	CGAffineTransform T = [self transformToCartesian:rect];
	
	CGContextConcatCTM ( X, T );
//--------------------------------------------------------------------------------------------------------------------
	NSString* string = self.text;
	
	// A string is something like: 'hello world!'
	// An attributed string is something like 'hello world!' with 'Hello' in
	// Times new Roman, 14pt and 'world' in this is the Courier Bold.
	// An RTF file is basically an attributed string.
	
	CFMutableAttributedStringRef attStr;
	// get attributed-string from string
//--------------------------------------------------------------------------------------------------------------------
    UIFont* font = self.font;
    
    assert (font != nil);
    CTFontRef ctFont = CTFontCreateWithName((CFStringRef)font.fontName,
                                            font.pointSize,
                                            NULL);
    
    // In our example we just set the font, and specify ' only use ligatures when essential '.
    // Ligatures: on some fonts 'fit' comes out as only 2 glyphs; 'fi'+'t', because if 'f' and
    // 'i' are drawn separately, they will tend to be close together and messy. 'fi' is a ligature
    
    NSNumber* NS_0 = [NSNumber numberWithInteger:0];
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                (__bridge id) ctFont, kCTFontAttributeName, // NSFontAttributeName
                                (id) NS_0, kCTLigatureAttributeName,  // NSLigatureAttributeName
                                (id) @(self.kern), kCTKernAttributeName,
                                
                                nil];
    assert(attributes != nil);
    
    NSMutableAttributedString* ns_attrString = [[NSMutableAttributedString alloc] initWithString:string
                                                                                      attributes:attributes];
    attStr = (__bridge CFMutableAttributedStringRef) ns_attrString;
//--------------------------------------------------------------------------------------------------------------------
    NSArray *linesLengths = [self linesCountsForAttributedString:attStr];
    CFIndex start;
    CFIndex length = 0;
    CFIndex sum = 0;
    CTLineRef line;
    CTTypesetterRef typesetter = CTTypesetterCreateWithAttributedString(attStr);
    
    for (int i = 0; i < [linesLengths count]-1; ++i) {
        
        if ((i+1) < [linesLengths count]) {
            if (i == 0) {
                start = 0;
                length = [[linesLengths objectAtIndex:1] longValue];
            } else {
                start = sum;
                length = [[linesLengths objectAtIndex:i+1] longValue];
            }
        }
        sum += length;
        
        line = CTTypesetterCreateLine(typesetter, CFRangeMake(start, length));
//--------------------------------------------------------------------------------------------------------------------
        //
        //Apply settings
        //
        UIColor *fillColor;
        UIColor *fillColor_;
        BOOL shadow;
        UIColor *shadowColor;
        CGFloat shadowBlur;
        CGSize shadowOffset;
        CGFloat lineSpacing;
        BOOL stroke;
        UIColor *strokeColor;
        CGFloat strokeWidth;
        OMGLabelTextAlignment al;
        NSArray *gradientColors = self.gradientColors;
        
        if (self.useSettings) {
            
            fillColor = self.fillColor;
            shadow = self.shadow;
            shadowColor = self.shadowColor;
            shadowBlur = self.shadowBlur;
            shadowOffset = self.shadowOffset;
            lineSpacing = self.lineSpacing;
            stroke = self.stroke;
            strokeColor = self.strokeColor;
            al = self.tAlignment;
            strokeWidth = self.strokeWidth;
            
            if ([self.settings.settings objectForKey:@(i)]) {
                NSDictionary *sets = [self.settings.settings objectForKey:@(i)];
                
                fillColor_ = [sets objectForKey:@(OMGLabelSettingsFillColor)];
                BOOL shadow_ = [[sets objectForKey:@(OMGLabelSettingsShadow)] boolValue];
                UIColor *shadowColor_ = [sets objectForKey:@(OMGLabelSettingsShadowColor)];
                CGFloat shadowBlur_ = [[sets objectForKey:@(OMGLabelSettingsShadowBlur)] floatValue];
                CGSize shadowOffset_ = [[sets objectForKey:@(OMGLabelSettingsShadowOffset)] CGSizeValue];
                CGFloat lineSpacing_ = [[sets objectForKey:@(OMGLabelSettingsLineSpacing)] floatValue];
                BOOL stroke_ = [[sets objectForKey:@(OMGLabelSettingsStroke)] boolValue];
                UIColor *strokeColor_ = [sets objectForKey:@(OMGLabelSettingsStrokeColor)];
                CGFloat strokeWidth_ = [[sets objectForKey:@(OMGLabelSettingsStrokeWidth)] floatValue];
                OMGLabelTextAlignment al_ = [[sets objectForKey:@(OMGLabelSettingsTextAlignment)] integerValue];
                NSArray *gradientColors_ = [sets objectForKey:@(OMGLabelSettingsGradientColors)];
                
                if (fillColor_)
                    fillColor = fillColor_;
                if (shadow_)
                    shadow = shadow_;
                if (shadowColor_)
                    shadowColor = shadowColor_;
                if (shadowBlur_)
                    shadowBlur = shadowBlur_;
                if (!CGSizeEqualToSize(shadowOffset_, CGSizeZero))
                    shadowOffset = shadowOffset_;
                if (lineSpacing_)
                    lineSpacing = lineSpacing_;
                if (stroke_)
                    stroke = stroke_;
                if (strokeColor_)
                    strokeColor = strokeColor_;
                if (strokeWidth_)
                    strokeWidth = strokeWidth_;
                if (al_)
                    al = al_;
                if ([gradientColors_ count] > 0)
                    gradientColors = gradientColors_;
                else
                    gradientColors = gradientColors;
            } else {
                fillColor = self.fillColor;
                shadow = self.shadow;
                shadowColor = self.shadowColor;
                shadowBlur = self.shadowBlur;
                shadowOffset = self.shadowOffset;
                lineSpacing = self.lineSpacing;
                stroke = self.stroke;
                strokeColor = self.strokeColor;
                al = self.tAlignment;
                strokeWidth = self.strokeWidth;
            }
        } else {
            fillColor = self.fillColor;
            shadow = self.shadow;
            shadowColor = self.shadowColor;
            shadowBlur = self.shadowBlur;
            shadowOffset = self.shadowOffset;
            lineSpacing = self.lineSpacing;
            stroke = self.stroke;
            strokeColor = self.strokeColor;
            al = self.tAlignment;
            strokeWidth = self.strokeWidth;
        }
//--------------------------------------------------------------------------------------------------------------------
        //
        // Text Alignment
        //
        CGRect lineBounds = CTLineGetImageBounds(line, X);
        NSLog(@"%@", NSStringFromCGRect(lineBounds));
        CGFloat leftGap;
        CGFloat topGap;
        switch (al) {
            case OMGLabelTextAlignmentLeft:
                leftGap = lineBounds.origin.x + 4.0f;
                break;
                
            case OMGLabelTextAlignmentMiddle:
                leftGap = self.frame.size.width/2 - lineBounds.size.width/2;
                break;
                
            case OMGLabelTextAlignmentRight:
                leftGap = self.frame.size.width - lineBounds.size.width;
                break;
        }
        
        CGFloat lineHeight = self.font.lineHeight+lineSpacing;
            
        CGFloat height = ([linesLengths count]-1)*lineHeight;
        switch (self.vAlignment) {
            case OMGLabelTextVerticalAlignmentBottom:
                topGap = self.frame.size.height - height - 2.0f;
                break;
                
            case OMGLabelTextVerticalAlignmentMiddle:
                topGap = self.frame.size.height/2.0f - height/2.0f;
                break;
                
            case OMGLabelTextVerticalAlignmentTop:
                topGap = lineBounds.origin.y;
                break;
        }
//--------------------------------------------------------------------------------------------------------------------
        CFArrayRef runArray = CTLineGetGlyphRuns(line);
        
        CGMutablePathRef linePath = CGPathCreateMutable();
        
        // for each RUN
        for (CFIndex runIndex = 0; runIndex < CFArrayGetCount(runArray); runIndex++)
        {
            // Get FONT for this run
            CTRunRef run = (CTRunRef)CFArrayGetValueAtIndex(runArray, runIndex);
            CTFontRef runFont = CFDictionaryGetValue(CTRunGetAttributes(run), kCTFontAttributeName);
            
            // for each GLYPH in run
            for (CFIndex runGlyphIndex = 0; runGlyphIndex < CTRunGetGlyphCount(run); runGlyphIndex++)
            {
                // get Glyph & Glyph-data
                CFRange thisGlyphRange = CFRangeMake(runGlyphIndex, 1);
                CGGlyph glyph;
                CGPoint position;
                CTRunGetGlyphs(run, thisGlyphRange, &glyph);
                CTRunGetPositions(run, thisGlyphRange, &position);
                position.y += -lineHeight*i-topGap;
                position.x += leftGap-lineBounds.origin.x - 2.0f;
                
                // draw green bounding box
//                {
//                    CGRect glyphRect = CTRunGetImageBounds(run, X, thisGlyphRange);
//                    glyphRect.origin.y -= defaultLineHeight*i;// position.y;// - 0.2*xHeight;
//                    
//                    CGContextSetLineWidth(X, atLeastOnePixel * 3);
//                    CGContextSetStrokeColorWithColor(X, [UIColor greenColor].CGColor);
//                    CGContextStrokeRect(X, glyphRect);
//                }
                
                {
                    CGPathRef path = CTFontCreatePathForGlyph(runFont, glyph, NULL);
                    CGRect pathRect = CGPathGetPathBoundingBox(path);
                    CGAffineTransform T = CGAffineTransformMakeTranslation(position.x, position.y);
                    CGMutablePathRef pT = CGPathCreateMutable();
                    CGPathAddPath(pT, &T, path);
                    if (shadow)
                        CGContextSetShadowWithColor(X, shadowOffset, shadowBlur, shadowColor.CGColor);
                    
                    CGRect glyphRect = CTRunGetImageBounds(run, X, thisGlyphRange);
                    glyphRect.origin.y += -lineHeight*i;

                    if (pathRect.size.width != 0 && pathRect.size.height != 0) {
                        CGContextAddPath(X, pT);
                        if (stroke) {
                            CGContextSetStrokeColorWithColor(X, strokeColor.CGColor);
                            CGContextSetLineWidth(X, strokeWidth);
                            CGContextDrawPath(X, kCGPathStroke);
                        }
                    }
                    
                    CGPathRelease(path);
                    CGPathAddPath(linePath, NULL, pT);
                    CGPathRelease(pT);
                }
            }
        }
//--------------------------------------------------------------------------------------------------------------------
        if ([gradientColors count] > 0 && !fillColor_) {
            //
            // Draw Gradient
            //
            CGContextAddPath(X, linePath);
            
            CGColorSpaceRef baseSpace = CGColorSpaceCreateDeviceRGB();
            size_t num_locations = [gradientColors count];
            CGFloat locations[num_locations];
            for (int k=0; k<num_locations; k++) {
                locations[k] = k / (CGFloat)(num_locations - 1); //we need the locations to start at 0.0 and end at 1.0, equaly filling the domain
            }
            
            CGFloat components[num_locations * 4];
            for (int i=0; i<num_locations; i++) {
                UIColor *color = [gradientColors objectAtIndex:num_locations-i-1];
                NSAssert(color.canProvideRGBComponents, @"Color components could not be extracted from StyleLabel gradient colors.");
                components[4*i+0] = color.red;
                components[4*i+1] = color.green;
                components[4*i+2] = color.blue;
                components[4*i+3] = color.alpha;
            }
            CGGradientRef gradient = CGGradientCreateWithColorComponents(baseSpace, components, locations, num_locations);
            CGColorSpaceRelease(baseSpace), baseSpace = NULL;
            
            CGContextSaveGState(X);
            CGContextClip(X);
            
            lineBounds.origin.y -= lineHeight*i+topGap;
            CGPoint startPoint = CGPointMake(CGRectGetMidX(lineBounds), CGRectGetMinY(lineBounds));
            CGPoint endPoint = CGPointMake(CGRectGetMidX(lineBounds), CGRectGetMaxY(lineBounds));
            
            CGContextDrawLinearGradient(X, gradient, startPoint, endPoint, 0);
            CGGradientRelease(gradient), gradient = NULL;
            
            CGContextRestoreGState(X);
        } else if (fillColor) {
            CGContextAddPath(X, linePath);
            CGContextSetFillColorWithColor(X, fillColor.CGColor);
            CGContextDrawPath(X, kCGPathFill);
        }
//--------------------------------------------------------------------------------------------------------------------
        CFRelease(line);
        CGPathRelease(linePath);
    }
}

- (CGAffineTransform)transformToCartesian:(CGRect)rect{
    CGAffineTransform T = CGAffineTransformIdentity;
    CGAffineTransform T00 = CGAffineTransformTranslate( T,
                                                       -rect.origin.x,
                                                       -rect.origin.y );
    
    CGAffineTransform T0022 = CGAffineTransformScale( T00,
                                                     1,
                                                     1 );
    
    CGAffineTransform Tud = CGAffineTransformTranslate( T0022, 0, self.font.pointSize );
    
    CGAffineTransform Tcart = CGAffineTransformScale( Tud, 1, -1 );
    
    return Tcart;
}

- (NSArray *)linesCountsForAttributedString:(CFAttributedStringRef)attrString{
    int start = 0;
    NSMutableArray *cArray = [[NSMutableArray alloc] initWithArray:@[@(start)]];
    while (start < self.text.length) {
        CFIndex index = [self lineLengthForAttributtedString:attrString fromIndex:start];
        [cArray addObject:@(index)];
        start += index;
    }
    return cArray;
}

- (CFIndex)lineLengthForAttributtedString:(CFAttributedStringRef)attrString fromIndex:(CFIndex)index{
    CTTypesetterRef typesetter = CTTypesetterCreateWithAttributedString(attrString);
    CFIndex count = CTTypesetterSuggestLineBreak(typesetter, index, self.frame.size.width);
    return count;
}

- (void)setSettings:(OMGLabelSettings *)settings{
    _settings = settings;
    if (settings)
        self.useSettings = YES;
    else
        self.useSettings = NO;
}

@end
