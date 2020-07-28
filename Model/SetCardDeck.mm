// Copyright (c) 2020 Lightricks. All rights reserved.
// Created by Barak Bukra.

#import "SetCardDeck.h"
#import "SetCard.h"
NS_ASSUME_NONNULL_BEGIN

@implementation SetCardDeck

- (instancetype)init
{
  self = [super init];
  
  if(self)
  {
      for(NSString *shape in [SetCard validShapes])
      {
        for(NSString *shading in [SetCard validShadings])
        {
          for(NSString *color in [SetCard validColors])
          {
            for(int i = kMinNumberOfShapes; i <= kMaxNumberOfShapes; i++)
            {
              SetCard *card = [[SetCard alloc] init];
              card.color = color;
              card.shape = shape;
              card.shading = shading;
              card.numberOfShapes = i;
              [self addCard:card];
            }
          }
        }
      }
  }
  
  return self;
}
@end

NS_ASSUME_NONNULL_END
