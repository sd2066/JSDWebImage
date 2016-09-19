//
//  UIImageView+SD.h
//  JSDWebImage
//
//  Created by Abner on 16/9/19.
//  Copyright © 2016年 Abner. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIImageView (SD)

@property(nonatomic,copy) NSString *lastURLString;

- (void)jsd_setImageWithUrlStr:(NSString *)urlStr;

@end
