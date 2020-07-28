// Copyright (c) 2020 Lightricks. All rights reserved.
// Created by Barak Bukra.

#import "Card.h"

#define kMaxNumberOfShapes 3
#define kMinNumberOfShapes 1
NS_ASSUME_NONNULL_BEGIN

@interface SetCard : Card
@property (nonatomic) NSUInteger numberOfShapes;
@property (strong, nonatomic) NSString *shading;
@property (strong, nonatomic) NSString *color;
@property (strong, nonatomic) NSString *shape;

+ (NSArray<NSString *> *)validColors;
+ (NSArray<NSString *> *)validShapes;
+ (NSArray<NSString *> *)validShadings;

@end

NS_ASSUME_NONNULL_END
