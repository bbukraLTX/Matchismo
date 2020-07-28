// Copyright (c) 2020 Lightricks. All rights reserved.
// Created by Barak Bukra.

#import "MatchHistoryVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface MatchHistoryVC()

@end

@implementation MatchHistoryVC
- (void)viewDidLoad
{
  self.playingCardHistory.attributedText = self.playingCardHistoryString;
  self.setCardHistory.attributedText = self.setCardHistoryString;
}
@end
NS_ASSUME_NONNULL_END
