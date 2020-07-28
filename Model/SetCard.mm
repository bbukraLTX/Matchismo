// Copyright (c) 2020 Lightricks. All rights reserved.
// Created by Barak Bukra.

#import "SetCard.h"

NS_ASSUME_NONNULL_BEGIN

@implementation SetCard



- (NSAttributedString *)contents {
  NSAttributedString *attributedContent = [[NSAttributedString alloc] init];
  NSMutableDictionary *attributesDict = [[NSMutableDictionary alloc] init];
  UIColor *color = ([self.color isEqualToString:@"red"]) ? [UIColor redColor] :
  ([self.color isEqualToString:@"purple"]) ? [UIColor purpleColor] : [UIColor greenColor];
  if ([self.shading isEqualToString:@"solid"])
      [attributesDict addEntriesFromDictionary:@{
          NSStrokeWidthAttributeName : @-5,
          NSStrokeColorAttributeName : color,
      NSForegroundColorAttributeName : color
                                            }];
  if ([self.shading isEqualToString:@"striped"])
      [attributesDict addEntriesFromDictionary:@{
           NSStrokeWidthAttributeName : @-5,
           NSStrokeColorAttributeName : color,
       NSForegroundColorAttributeName : [color
                                         colorWithAlphaComponent:0.4]
                                             }];
  if ([self.shading isEqualToString:@"open"])
      [attributesDict addEntriesFromDictionary:@{
          NSStrokeWidthAttributeName : @5,
          NSStrokeColorAttributeName : color
                                            }];
  return [attributedContent initWithString:[NSString stringWithFormat:@"%lu%@", (unsigned long)self.numberOfShapes, self.shape] attributes:attributesDict];
}

+ (NSArray<NSString *> *)validColors {
  return @[@"red", @"green", @"purple"];
}
+ (NSArray<NSString *> *)validShapes {
    return @[@"▲", @"●", @"■"]; 
}
+ (NSArray<NSString *> *)validShadings {
  return @[@"solid", @"striped", @"open"];
}

- (void)setColor:(NSString *)color {
  NSArray *validColors = [SetCard validColors];
  if ([validColors containsObject:color]) {
    _color = color;
  }
}

- (void)setShape:(NSString *)shape{
  NSArray *validShapes = [SetCard validShapes];
  if ([validShapes containsObject:shape]) {
    _shape = shape;
  }
}

- (void)setShading:(NSString *)shading {
  NSArray *validShadings = [SetCard validShadings];
  if ([validShadings containsObject:shading]) {
    _shading = shading;
  }
}

- (void)setNumberOfShapes:(NSUInteger)numberOfShapes {
  if(kMinNumberOfShapes <= numberOfShapes && numberOfShapes <= kMaxNumberOfShapes)
  {
    _numberOfShapes = numberOfShapes;
  }
}

+ (BOOL)equalityInThrees: (NSArray <NSString *>*)three
{
  if([three[0] isEqualToString:three[1]] &&
     [three[1] isEqualToString:three[2]])
  {
    return YES;
  }
  return NO;
}

+ (BOOL)inequalityInThrees:(NSArray <NSString *>*)three {
  if(![three[0] isEqualToString:three[1]] &&
     ![three[1] isEqualToString:three[2]] &&
     ![three[0] isEqualToString:three[2]]) {
    return YES;
  }
  return NO;
}

+ (BOOL)testForSetMatching:(NSArray <SetCard *>*)cards {
  if(![SetCard equalityInThrees:@[cards[0].color, cards[1].color, cards[2].color]] &&
     ![SetCard inequalityInThrees:@[cards[0].color, cards[1].color, cards[2].color]])
  {
    return NO;
  }
  if(![SetCard equalityInThrees:@[cards[0].shading, cards[1].shading, cards[2].shading]] &&
     ![SetCard inequalityInThrees:@[cards[0].shading, cards[1].shading, cards[2].shading]])
  {
    return NO;
  }
  if(![SetCard equalityInThrees:@[cards[0].shape, cards[1].shape, cards[2].shape]] &&
     ![SetCard inequalityInThrees:@[cards[0].shape, cards[1].shape, cards[2].shape]])
  {
    return NO;
  }
  NSArray<NSString *> *numberOfShapesStringArray =
      @[[NSString stringWithFormat: @"%lu", cards[0].numberOfShapes],
        [NSString stringWithFormat: @"%lu", cards[1].numberOfShapes],
        [NSString stringWithFormat: @"%lu", cards[2].numberOfShapes]];
  if(![SetCard equalityInThrees:numberOfShapesStringArray] &&
     ![SetCard inequalityInThrees:numberOfShapesStringArray])
  {
    return NO;
  }
  return YES;
}

- (int)match:(NSArray *)otherCards {
  int score = 0;
  if(otherCards.count == 2)
  {
    NSArray *allChosenCards = @[self, otherCards[0], otherCards[1]];
    if([SetCard testForSetMatching:allChosenCards])
    {
      score = 10;
    }
    else
    {
      score = 0;
    }
  }
  
  return score;
}

@end

NS_ASSUME_NONNULL_END
