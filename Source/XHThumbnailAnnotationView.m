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

@interface XHThumbnailAnnotationView () {
@private
    CAShapeLayer *_shapeLayer;
    CAShapeLayer *_strokeAndShadowLayer;
    UIButton *_disclosureButton;
    XHThumbnailAnnotationViewState _state;
}

@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *userNameLabel;
@property (nonatomic, strong) UILabel *distanceLabel;

@end

@implementation XHThumbnailAnnotationView

#pragma mark - Action

- (void)didTapDisclosureButton:(id)sender {
    if (_disclosureBlock) _disclosureBlock();
}

#pragma mark - life cycle

- (instancetype)initWithAnnotation:(id<MKAnnotation>)annotation {
    self = [super initWithAnnotation:annotation reuseIdentifier:@"XHThumbnailAnnotationView"];
    if (self) {
        [self _setup];
    }
    return self;
}

- (void)_setup {
    self.canShowCallout = NO;
    self.frame = CGRectMake(0, 0, XHThumbnailAnnotationViewStandardWidth, XHThumbnailAnnotationViewStandardHeight);
    self.backgroundColor = [UIColor clearColor];
    self.centerOffset = CGPointMake(0, -XHThumbnailAnnotationViewVerticalOffset);
    
    // Image View
    _avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(12.5, 12, 50, 47)];
    _avatarImageView.layer.cornerRadius = 4.0;
    _avatarImageView.layer.masksToBounds = YES;
    _avatarImageView.layer.borderColor = [[UIColor blackColor] CGColor];
    _avatarImageView.layer.borderWidth = 1;
    [self addSubview:self.avatarImageView];
    
    // Name Label
    _userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(-32, 20, 168, 20)];
    _userNameLabel.backgroundColor = [UIColor clearColor];
    _userNameLabel.textColor = [UIColor whiteColor];
    _userNameLabel.shadowColor = [UIColor colorWithWhite:0 alpha:0.5];
    _userNameLabel.shadowOffset = CGSizeMake(0, -1);
    _userNameLabel.font = [UIFont boldSystemFontOfSize:17];
    _userNameLabel.alpha = 0;
    _userNameLabel.minimumScaleFactor = .8f;
    _userNameLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:self.userNameLabel];
    
    // Distance Label
    _distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(-32, 36, 168, 20)];
    _distanceLabel.backgroundColor = [UIColor clearColor];
    _distanceLabel.textColor = [UIColor whiteColor];
    _distanceLabel.shadowColor = [UIColor colorWithWhite:0 alpha:0.5];
    _distanceLabel.shadowOffset = CGSizeMake(0, -1);
    _distanceLabel.font = [UIFont systemFontOfSize:12];
    _distanceLabel.alpha = 0;
    [self addSubview:self.distanceLabel];
    
    // Disclosure button
    _disclosureButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    _disclosureButton.frame = CGRectMake(XHThumbnailAnnotationViewExpandOffset/2 + self.frame.size.width/2 - 4.0f, 21, _disclosureButton.frame.size.width, _disclosureButton.frame.size.height);
    
    [_disclosureButton addTarget:self action:@selector(didTapDisclosureButton:) forControlEvents:UIControlEventTouchDown];
    _disclosureButton.alpha = 0;
    [self addSubview:_disclosureButton];
    
    _state = XHThumbnailAnnotationViewStateCollapsed;
    
    [self _setLayerProperties];
}

- (void)_setLayerProperties {
    _shapeLayer = [ShadowShapeLayer layer];
    CGPathRef shapeLayerPath = [self newBubbleWithRect:self.bounds andOffset:CGSizeMake(XHThumbnailAnnotationViewExpandOffset/2, 0)];
    _shapeLayer.path = shapeLayerPath;
    CGPathRelease(shapeLayerPath);
    
    // Fill Callout Bubble & Add Shadow
    _shapeLayer.fillColor = [[UIColor blackColor] CGColor];
    
    _strokeAndShadowLayer = [CAShapeLayer layer];
    
    CGPathRef _strokeAndShadowLayerPath = [self newBubbleWithRect:self.bounds];
    _strokeAndShadowLayer.path = _strokeAndShadowLayerPath;
    CGPathRelease(_strokeAndShadowLayerPath);
    
    _strokeAndShadowLayer.fillColor = [UIColor clearColor].CGColor;
    
    if (XHThumbnailAnnotationViewShadowVisible) {
        _strokeAndShadowLayer.shadowColor = [UIColor blackColor].CGColor;
        _strokeAndShadowLayer.shadowOffset = CGSizeMake (0, [[[UIDevice currentDevice] systemVersion] floatValue] >= 3.2 ? 3 : -3);
        _strokeAndShadowLayer.shadowRadius = 5.0;
        _strokeAndShadowLayer.shadowOpacity = 1.0;
    }
    
    _strokeAndShadowLayer.strokeColor = [UIColor colorWithWhite:0.22 alpha:1.0].CGColor;
    _strokeAndShadowLayer.lineWidth = 1.0;
    
    CAGradientLayer *bubbleGradient = [CAGradientLayer layer];
    bubbleGradient.frame = CGRectMake(self.bounds.origin.x-XHThumbnailAnnotationViewExpandOffset/2, self.bounds.origin.y, XHThumbnailAnnotationViewExpandOffset+self.bounds.size.width, self.bounds.size.height-7);
    bubbleGradient.colors = [NSArray arrayWithObjects:(id)[UIColor colorWithWhite:0 alpha:.75].CGColor, (id)[UIColor colorWithWhite:0 alpha:.75].CGColor,(id)[UIColor colorWithWhite:0.13 alpha:.75].CGColor,(id)[UIColor colorWithWhite:0.33 alpha:.75].CGColor, nil];
    bubbleGradient.locations = [NSArray arrayWithObjects:[NSNumber numberWithFloat:0],[NSNumber numberWithFloat:0.53],[NSNumber numberWithFloat:.54],[NSNumber numberWithFloat:1], nil];
    bubbleGradient.startPoint = CGPointMake(0.0f, 1.0f);
    bubbleGradient.endPoint = CGPointMake(0.0f, 0.0f);
    bubbleGradient.mask = _shapeLayer;
    
    _shapeLayer.masksToBounds = NO;
    bubbleGradient.masksToBounds = NO;
    _strokeAndShadowLayer.masksToBounds = NO;
    
    [_strokeAndShadowLayer addSublayer:bubbleGradient];
    [self.layer insertSublayer:_strokeAndShadowLayer atIndex:0];
}

@end
