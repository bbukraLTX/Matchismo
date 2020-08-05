// Copyright (c) 2020 Lightricks. All rights reserved.
// Created by Barak Bukra.

#import "PlayingCardVC.h"
#import "PlayingCardDeck.h"

NS_ASSUME_NONNULL_BEGIN

@interface PlayingCardVC()
@property (weak, nonatomic) IBOutlet UIView *cardsView;


@end
@implementation PlayingCardVC




@synthesize cardDeck = _cardDeck;
- (Deck *)createNewDeck // abstract
{
  _cardDeck = [[PlayingCardDeck alloc] init];
  return _cardDeck;
}

- (Deck *)cardDeck
{
  if(!_cardDeck)
  {
    _cardDeck = [[PlayingCardDeck alloc] init];
  }
  return _cardDeck;
}


- (matchingType)getGameMode { 
  return _2match;
}

@end

NS_ASSUME_NONNULL_END
