//
//  XHThumbnailUser.m
//  XHThumbnailAnnotation
//
//  Created by 曾 宪华 on 14-1-17.
//  Copyright (c) 2014年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507 本人QQ群（142557668）. All rights reserved.
//

#import "XHThumbnailUser.h"

@implementation XHThumbnailUser

- (void)dealloc {
    self.avatarImage = nil;
    self.avartarImageUrl = nil;
    self.userName = nil;
    self.distance = nil;
}

@end
