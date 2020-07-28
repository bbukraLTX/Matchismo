//
//  ViewController.m
//  Matchismo
//
//  Created by Barak Bukra on 20/07/2020.
//  Copyright © 2020 Barak Bukra. All rights reserved.
//

#import "ViewController.h"
#import "MatchHistoryVC.h"
//@class MatchHistoryVC;

@interface ViewController ()
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControlButton;
@property (weak, nonatomic) IBOutlet UILabel *resultsLabel;
@property (nonatomic) BOOL matchingAttemptedOnChoice;
@property (readwrite, nonatomic) NSMutableAttributedString *history;
@end




@implementation ViewController

- (NSMutableAttributedString *)history
{
  if(!_history)
  {
    _history = [[NSMutableAttributedString alloc] init];
  }
  return _history;
}
- (CardMatchingGame *)game
{
  if(!_game)
  {
    _game = [[CardMatchingGame alloc] initWithCardCount:_cardButtons.count
                                              usingDeck:[self cardDeck]];
  }
  return _game;
}

- (Deck *)createNewDeck // abstract
{
  return nil;
}
- (Deck *)cardDeck // abstract
{
  return nil;
}

- (IBAction)touchCardButton:(UIButton *)sender
{
  NSUInteger chooseButtonIndex = [self.cardButtons indexOfObject:sender];
  NSInteger countChosenCardsBefore = [self countChosenCards];
  self.game.gameMode = [self getGameMode];
  self.matchingAttemptedOnChoice = (countChosenCardsBefore == self.game.gameMode - 1) ? YES : NO;
  self.resultsLabel.attributedText = [self chosenCardsContents];
  [self.game chooseCardAtIndex:chooseButtonIndex];
  [self updateUI];
  [self updateResultsLabel:chooseButtonIndex];
}

- (NSAttributedString *)chosenCardsContents
{
  NSMutableAttributedString *chosenCardsContents = [[NSMutableAttributedString alloc] init];
  for(UIButton *cardButton in self.cardButtons)
  {
    NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
    Card *card = [self.game cardAtIndex:cardButtonIndex];
    if(card.chosen && !card.matched)
    {
      [chosenCardsContents appendAttributedString:card.contents];
//      chosenCardsContents = [NSString stringWithFormat:@"%@ %@", chosenCardsContents, card.contents];
    }
  }
  return chosenCardsContents;
}

//- (NSString *)chosenCardsContents
//{
//  NSString *chosenCardsContents = @"";
//  for(UIButton *cardButton in self.cardButtons)
//  {
//    NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
//    Card *card = [self.game cardAtIndex:cardButtonIndex];
//    if(card.chosen && !card.matched)
//    {
//      chosenCardsContents = [NSString stringWithFormat:@"%@ %@", chosenCardsContents, card.contents];
//    }
//  }
//  return chosenCardsContents;
//}

- (void)updateResultsLabel:(NSUInteger) chooseButtonIndex
{
  Card *card = [self.game cardAtIndex:chooseButtonIndex];
  NSMutableAttributedString *currentAttributedText = [[NSMutableAttributedString alloc] init];
  if(_matchingAttemptedOnChoice)
  {
    currentAttributedText = [currentAttributedText initWithAttributedString:self.resultsLabel.attributedText];
    [currentAttributedText appendAttributedString:card.contents];
    if([self countChosenCards] == 0)
    {
      // there was a match
//      self.resultsLabel.text =
//          [NSString stringWithFormat:@"%@ %@ match", self.resultsLabel.text, card.contents];
      NSAttributedString *str = [[NSAttributedString alloc] init];;
      str = [str initWithString:@" match" attributes:nil];
      [currentAttributedText appendAttributedString: str];
    }
    else
    {
//      self.resultsLabel.text =
//          [NSString stringWithFormat:@"%@ %@ mismatch", self.resultsLabel.text, card.contents];
      NSAttributedString *str = [[NSAttributedString alloc] init];
      str = [str initWithString:@" mismatch" attributes:nil];
      [currentAttributedText appendAttributedString: str];
    }
    [self.history appendAttributedString:currentAttributedText];
    [self.history appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n" attributes: nil]];
    self.resultsLabel.attributedText = currentAttributedText;
  }
  else
  {
    self.resultsLabel.attributedText = [self chosenCardsContents];
  }
}

- (void)updateUI
{
  self.segmentedControlButton.enabled = self.game.hasGameStarted ? NO : YES;

  for(UIButton *cardButton in self.cardButtons)
  {
    NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
    Card *card = [self.game cardAtIndex:cardButtonIndex];
    [cardButton setAttributedTitle:(card.chosen ? card.contents : [[NSAttributedString alloc] init]) forState:UIControlStateNormal];
    [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
    cardButton.enabled = !card.matched;
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", self.game.score];
  }
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
  NSString *imageName = card.chosen ? @"cardfront": @"cardback";
  return [UIImage imageNamed: imageName];
}

- (NSInteger)countChosenCards
{
  int count = 0;
  for(UIButton *cardButton in self.cardButtons)
  {
    NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
    Card *card = [self.game cardAtIndex:cardButtonIndex];
    if(card.chosen && !card.matched)
    {
      count++;
    }
  }
  return count;
}

- (matchingType)getGameMode { // abstract
  return _2match;
}
- (IBAction)onPressResetButton:(UIButton *)sender
{
  _cardDeck = [self createNewDeck];
  _game = [[CardMatchingGame alloc]
           initWithCardCount:_cardButtons.count
                   usingDeck:[self cardDeck]];
  _resultsLabel.text = @"";
  
//  NSInteger index = [self.segmentedControlButton selectedSegmentIndex];
//  NSString *currentChoice = [self.segmentedControlButton titleForSegmentAtIndex:index];
  self.game.gameMode = [self getGameMode];
  [self.history appendAttributedString:[[NSAttributedString alloc]
                                        initWithString:@"Reset Button Pressed\n"
                                            attributes: nil]];
  [self updateUI];
}

- (IBAction)onChangeSegmentedControl:(UISegmentedControl *)sender
{
  NSInteger index = [sender selectedSegmentIndex];
  NSString *currentChoice = [sender titleForSegmentAtIndex:index];
  self.game.gameMode = ([currentChoice isEqualToString:@"2-match"]) ? _2match : _3match;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqualToString:@"playingCardHistory"]) {
    if ([segue.destinationViewController isKindOfClass:[MatchHistoryVC class]]) {
      MatchHistoryVC *doVC = (MatchHistoryVC *)segue.destinationViewController;
      doVC.playingCardHistoryString = self.history;
    }
  }
  if ([segue.identifier isEqualToString:@"setMatchHistory"]) {
    if ([segue.destinationViewController isKindOfClass:[MatchHistoryVC class]]) {
      MatchHistoryVC *doVC = (MatchHistoryVC *)segue.destinationViewController;
      doVC.setCardHistoryString = self.history;
    }
  }
}

@end
