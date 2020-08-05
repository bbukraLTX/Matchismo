// Copyright (c) 2020 Lightricks. All rights reserved.
// Created by Barak Bukra.

#import "SetVC.h"
#import "SetCardDeck.h"
#import "SetCardView.h"
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
- (IBAction)draw3CardsButton:(UIButton *)sender {
  if(self.game.cards.count > 20) {
    return;
  }
  for(int i = 0; i < 3; i++) {
    Card *card = [self.game.deck drawRandomCard];
    if(!card) {
      sender.enabled = NO;
    }
    [self.game.cards addObject:card];

    NSUInteger pos = self.cardViews.count + 1;
    NSUInteger columnCount = [self.grid columnCount];
    
    SetCardView *newCardView = [[SetCardView alloc] initWithFrame:sender.frame];
    [newCardView setPropertiesWithCard:card];
    [newCardView addGestureRecognizer:[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeCardRight:)]];
    
    [UIView transitionWithView:newCardView duration:0.5 options:UIViewAnimationTransitionFlipFromLeft animations:^{
          [newCardView setFrame:[self.grid
                                 frameOfCellAtRow: pos / columnCount inColumn:pos % columnCount]];
          [self.cardViews addObject:newCardView];
          [self.cardsView addSubview:newCardView];
    } completion:nil];

  }
  
  [self rearrangeBoard];
}


- (matchingType)getGameMode {
  return _3match;
}
@end

NS_ASSUME_NONNULL_END
