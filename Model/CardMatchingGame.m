//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Barak Bukra on 21/07/2020.
//  Copyright © 2020 Barak Bukra. All rights reserved.
//
#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, readwrite) BOOL hasGameStarted;
@property (nonatomic, strong) NSMutableArray *cards;
@end
@implementation CardMatchingGame


- (NSMutableArray *)cards
{
  if(!_cards)
  {
    _cards = [[NSMutableArray alloc] init];
  }
  return _cards;
}


- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
  self.gameMode = _2match;
  self.hasGameStarted = NO;
  if(self = [super init])
  {
    for(int i = 0; i < count; i++)
    {
      Card *card = [deck drawRandomCard];
      if(card)
      {
        [self.cards addObject:card];
      }
      else
      {
        self = nil;
        break;
      }
    }
  }
  return self;
}

static const int COST_TO_CHOOSE = 1;
static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;

- (int)calcScore:(NSArray<Card *> *)allChosenCards {
  int score = 0;
  if(self.gameMode == _2match)
  {
    for(int i = 0; i < allChosenCards.count; i++) {
      for(int j = i + 1; j < allChosenCards.count; j++) {
        score += [allChosenCards[i] match:@[allChosenCards[j]]];
      }
    }
  }
  else if(self.gameMode == _3match)
  {
    // certainly there are 3 cards in the array because we've passed this condition before
    score += [allChosenCards[0] match: @[allChosenCards[1], allChosenCards[2]]];
  }
  return score;
}

- (void)handleChoice:(Card *)card {
  NSMutableArray *otherChosenCards = [[NSMutableArray alloc] init];
  for(Card *otherCard in self.cards)
  {
    if(otherCard.chosen && !otherCard.matched)
    {
      [otherChosenCards addObject:otherCard];
    }
  }
  if(otherChosenCards.count == self.gameMode - 1)
  {
    [otherChosenCards addObject:card];
    int matchScore = [self calcScore:otherChosenCards];
    if(matchScore)
    {
      self.score += matchScore * MATCH_BONUS;
      for(Card *currentCard in otherChosenCards)
      {
        currentCard.matched = YES;
      }
    }
    else
    {
      self.score -= MISMATCH_PENALTY;
      for(Card *currentCard in otherChosenCards)
      {
        if(![currentCard isEqual:card])
        {
          currentCard.chosen = NO;
        }
      }
    }
  }
}

- (void)chooseCardAtIndex:(NSUInteger)index
{
  Card *card = [self cardAtIndex:index];
  
  if(!self.hasGameStarted)
  {
    self.hasGameStarted = YES;
  }
  // debugging:
  if(!card)
  {
    NSLog(@"This should not happen");
    return;
  }
  
  if(!card.matched)
  {
    if(card.chosen)
    {
      card.chosen = NO;
    }
    else
    {
      [self handleChoice:card];
      self.score -= COST_TO_CHOOSE;
      card.chosen = YES;
    }
  }
}

- (Card *)cardAtIndex:(NSUInteger)index
{
  Card *card = nil;
  if(index < self.cards.count)
  {
    card = self.cards[index];
  }
  return card;
}

@end
