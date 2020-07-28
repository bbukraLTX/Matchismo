//
//  Deck.h
//  Matchismo
//
//  Created by Barak Bukra on 20/07/2020.
//  Copyright © 2020 Barak Bukra. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "Card.h"
#ifndef Deck_h
#define Deck_h

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (void)addCard:(Card *)card;
- (Card *) drawRandomCard;
@end

#endif /* Deck_h */
