//
//  XHThumbnailAnnotationView.h
//  XHThumbnailAnnotation
//
//  Created by 曾 宪华 on 14-1-17.
//  Copyright (c) 2014年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507 本人QQ群（142557668）. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

#import "XHThumbnail.h"

@interface XHThumbnailAnnotationView : MKAnnotationView

// 显示简单的信息，详细信息需要在详细页面
@property (nonatomic, readwrite) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *userNameLabel;
@property (nonatomic, strong) UILabel *distanceLabel;
@property (nonatomic, copy) XHThumbnailActionBlock disclosureBlock;

- (id)initWithAnnotation:(id <MKAnnotation> )annotation;


@end
