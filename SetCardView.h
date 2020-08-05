// Copyright (c) 2020 Lightricks. All rights reserved.
// Created by Barak Bukra.

#import <UIKit/UIKit.h>
#import "CardView.h"
#import "SetCard.h"
NS_ASSUME_NONNULL_BEGIN

@interface SetCardView : CardView
@property (nonatomic) NSUInteger numberOfShapes;
@property (strong, nonatomic) NSString *shading;
@property (strong, nonatomic) NSString *color;
@property (strong, nonatomic) NSString *shape;

@end

NS_ASSUME_NONNULL_END
