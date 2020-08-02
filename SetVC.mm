// Copyright (c) 2020 Lightricks. All rights reserved.
// Created by Barak Bukra.

#import "SetVC.h"
#import "SetCardDeck.h"
NS_ASSUME_NONNULL_BEGIN

@implementation SetVC
@synthesize cardDeck = _cardDeck;
- (Deck *)createNewDeck
{
  _cardDeck = [[SetCardDeck alloc] init];
  return _cardDeck;
}

- (Deck *)cardDeck
{
  if(!_cardDeck)
  {
    _cardDeck = [[SetCardDeck alloc] init];
  }
  return _cardDeck;
}


- (matchingType)getGameMode {
  return _3match;
}
@end

NS_ASSUME_NONNULL_END
