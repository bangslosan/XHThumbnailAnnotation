//
//  XHThumbnailAnnotationView.m
//  XHThumbnailAnnotation
//
//  Created by 曾 宪华 on 14-1-17.
//  Copyright (c) 2014年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507 本人QQ群（142557668）. All rights reserved.
//

#import "XHThumbnailAnnotationView.h"

#define XHThumbnailAnnotationViewStandardWidth     75.0f
#define XHThumbnailAnnotationViewStandardHeight    87.0f
#define XHThumbnailAnnotationViewExpandOffset      200.0f
#define XHThumbnailAnnotationViewVerticalOffset    34.0f
#define XHThumbnailAnnotationViewAnimationDuration 0.25f
#define XHThumbnailAnnotationViewShadowVisible     TRUE

@interface ShadowShapeLayer : CAShapeLayer
@end

@implementation ShadowShapeLayer

- (void)drawInContext:(CGContextRef)context {
    CGContextSaveGState(context);
    CGContextSetShadow(context, CGSizeMake(0, 6), 6);
    [super drawInContext:context];
    CGContextRestoreGState(context);
}

@end

@implementation XHThumbnailAnnotationView

- (instancetype)initWithAnnotation:(id<MKAnnotation>)annotation {
    self = [super initWithAnnotation:annotation reuseIdentifier:@"XHThumbnailAnnotationView"];
    if (self) {
        [self _setup];
    }
    return self;
}

- (void)_setup {
    
}

@end
