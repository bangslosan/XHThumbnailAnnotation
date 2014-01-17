//
//  XHThumbnail.h
//  XHThumbnailAnnotation
//
//  Created by 曾 宪华 on 14-1-17.
//  Copyright (c) 2014年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507 本人QQ群（142557668）. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "XHThumbnailUser.h"

typedef void (^XHThumbnailActionBlock)();

@interface XHThumbnail : NSObject
@property (nonatomic, strong) XHThumbnailUser *thumbnailUser;
@property (nonatomic, readwrite) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) XHThumbnailActionBlock disclosureBlock;
@end
