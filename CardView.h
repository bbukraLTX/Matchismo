// Copyright (c) 2020 Lightricks. All rights reserved.
// Created by Barak Bukra.
#import <UIKit/UIKit.h>
#import "Card.h"
NS_ASSUME_NONNULL_BEGIN
/// Abstract class
@interface CardView : UIView
@property (nonatomic) BOOL faceUp;
- (void)setPropertiesWithCard:(Card *)card;
@end

NS_ASSUME_NONNULL_END
