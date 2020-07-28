//
//  Deck.m
//  Matchismo
//
//  Created by Barak Bukra on 20/07/2020.
//  Copyright © 2020 Barak Bukra. All rights reserved.
//


#import "Deck.h"

@interface Deck()
@property (strong, nonatomic) NSMutableArray *cards;
@end

@implementation Deck

- (NSMutableArray *) cards
{
  if(!_cards)
  {
    _cards = [[NSMutableArray alloc] init];
  }
  return _cards;
}

- (void)addCard:(Card *)card atTop:(BOOL)atTop
{
  if(atTop)
  {
    [self.cards insertObject:card atIndex:0];
  }
  else
  {
    [self.cards addObject:card];
  }
}
- (void)addCard:(Card *)card
{
  [self addCard:card atTop:NO];
}
- (Card *) drawRandomCard
{
  Card * randomCard = Nil;
  if([self.cards count] != 0)
  {
    unsigned index = arc4random() % [self.cards count];
    randomCard = self.cards[index];
    [self.cards removeObjectAtIndex:index];
  }
  return randomCard;
}


@end
