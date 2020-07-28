//
//  PlayingCard.m
//  Matchismo
//
//  Created by Barak Bukra on 20/07/2020.
//  Copyright © 2020 Barak Bukra. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (NSAttributedString *)contents
{
  unsigned long long rank = self.rank;
  NSArray *rankString = [PlayingCard rankStrings];
  return [[NSAttributedString alloc] initWithString:[rankString[rank] stringByAppendingString:self.suit] attributes: @{NSForegroundColorAttributeName: [UIColor blackColor]}];
}

+ (NSUInteger)maxRank
{
  return [[PlayingCard rankStrings] count] - 1;
}

+ (NSArray *)validSuits
{
  return @[@"♠️", @"♣️", @"♥️", @"♦️"];
}

- (void)setRank:(NSUInteger)rank
{
  if(rank <= [PlayingCard maxRank])
  {
    _rank = rank;
  }
}

@synthesize suit = _suit; // getter AND setter were changed

- (void)setSuit:(NSString *)suit
{
  if([[PlayingCard validSuits] containsObject:suit])
  {
    _suit = suit;
  }
}

- (NSString *)suit
{
  return _suit ? _suit : @"?";
}


+ (NSArray *)rankStrings
{
  return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

-(int)match:(NSArray *)otherCards
{
  int score = 0;
//  for(Card *card in otherCards)
//  {
//
//  }
  if(otherCards.count == 1)
  {
    PlayingCard *otherCard = [otherCards firstObject];
    if(otherCard.rank == self.rank)
    {
      score = 4;
    }
    else if([otherCard.suit isEqualToString:self.suit])
    {
      score = 1;
    }
  }
  return score;
}

@end
