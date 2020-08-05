// Copyright (c) 2020 Lightricks. All rights reserved.
// Created by Barak Bukra.

#import "SetCardView.h"

NS_ASSUME_NONNULL_BEGIN

@implementation SetCardView

- (void)setPropertiesWithCard:(Card *)card {
  SetCard *setCard = (SetCard *)card;
  self.color = setCard.color;
  self.shape = setCard.shape;
  self.shading = setCard.shading;
  self.numberOfShapes = setCard.numberOfShapes;
}

- (void)setShading:(NSString *)shading {
  _shading = shading;
  [self setNeedsDisplay];
}

- (void)setShape:(NSString *)shape {
  _shape = shape;
  [self setNeedsDisplay];
}

- (void)setNumberOfShapes:(NSUInteger)numberOfShapes {
  _numberOfShapes = numberOfShapes;
    [self setNeedsDisplay];
}

- (void)setColor:(NSString *)color {
  _color = color;
  [self setNeedsDisplay];
}

- (void)drawDiamond:(UIBezierPath *)path :(CGPoint)startingPoint {
  [path moveToPoint:startingPoint];
  [path addLineToPoint:CGPointMake((startingPoint.x + (self.bounds.size.width - startingPoint.x)) / 2, startingPoint.y  + self.bounds.size.height / 8)];
  [path addLineToPoint:CGPointMake(self.bounds.size.width - startingPoint.x, startingPoint.y)];
  [path addLineToPoint:CGPointMake((startingPoint.x + (self.bounds.size.width - startingPoint.x)) / 2, startingPoint.y - self.bounds.size.height / 8)];
  [path closePath];
}

- (void)drawSquiggle:(UIBezierPath *)path :(CGPoint)startingPoint {
  CGFloat rightEndX = self.bounds.size.width - startingPoint.x;
  CGFloat middleX = startingPoint.x + (rightEndX - startingPoint.x) / 2;
  CGFloat middleRightX = middleX + ((rightEndX - middleX) / 2);
  CGFloat middleLeftX = startingPoint.x + ((middleX - startingPoint.x) / 2);
  
  CGFloat topY = startingPoint.y - (self.bounds.size.height / 8);
  CGFloat botY = startingPoint.y + (self.bounds.size.height / 8);
  
  [path moveToPoint:startingPoint];
  [path addQuadCurveToPoint:CGPointMake(middleX, startingPoint.y)
               controlPoint:CGPointMake(middleLeftX, topY)];
  [path addQuadCurveToPoint:CGPointMake(rightEndX, startingPoint.y)
               controlPoint:CGPointMake(middleRightX, topY)];
  [path addQuadCurveToPoint:CGPointMake(middleX, startingPoint.y)
               controlPoint:CGPointMake(middleRightX, botY)];
  [path addQuadCurveToPoint:CGPointMake(startingPoint.x, startingPoint.y)
               controlPoint:CGPointMake(middleLeftX, botY)];
  [path closePath];
  
}

- (void)drawOval:(UIBezierPath *)path :(CGPoint)startingPoint {
  [path moveToPoint:startingPoint];
  [path addQuadCurveToPoint:CGPointMake(startingPoint.x + self.bounds.size.width / 5,
                                        startingPoint.y + self.bounds.size.height / 8)
               controlPoint:CGPointMake(startingPoint.x,
                                        startingPoint.y + self.bounds.size.height / 8)];
  [path addLineToPoint:CGPointMake(self.bounds.size.width * (4 / 5.0), path.currentPoint.y)];
  [path addQuadCurveToPoint:CGPointMake(self.bounds.size.width * (7 / 8.0),
                                        startingPoint.y)
               controlPoint:CGPointMake(self.bounds.size.width * (7 / 8.0),
                                        path.currentPoint.y)];
  [path addQuadCurveToPoint:CGPointMake(self.bounds.size.width * (4 / 5.0),
                                        path.currentPoint.y - self.bounds.size.height / 8)
               controlPoint:CGPointMake(self.bounds.size.width * (7 / 8.0),
                                        path.currentPoint.y - self.bounds.size.height / 8)];
  [path addLineToPoint:CGPointMake(self.bounds.size.width / 5.0, path.currentPoint.y)];
  [path addQuadCurveToPoint:CGPointMake(startingPoint.x,
                                        startingPoint.y)
               controlPoint:CGPointMake(startingPoint.x,
                                        path.currentPoint.y)];
  [path closePath];
}

- (UIBezierPath *)drawShapes {
  UIBezierPath *path = [[UIBezierPath alloc] init];
  for(int i = 0; i < self.numberOfShapes; i++) {
    CGPoint startingPoint = CGPointMake(self.bounds.size.width / 8,
                                        self.bounds.size.height * ((i * 2 + 1)/ 6.0));
    if([self.shape isEqualToString:@"■"]) {
      // squiggle
      [self drawSquiggle:path :startingPoint];
    } else if([self.shape isEqualToString:@"▲"]) {
      // diamond
      [self drawDiamond:path :startingPoint];
    } else {
      [self drawOval:path :startingPoint];
    }
  }
  return path;
}

- (void)setColor {
  if([self.color isEqualToString:@"red"]) {
    [[UIColor redColor] setFill];
    [[UIColor redColor] setStroke];
  }
  else if([self.color isEqualToString:@"green"]) {
    [[UIColor greenColor] setFill];
    [[UIColor greenColor] setStroke];
  } else {
    [[UIColor purpleColor] setFill];
    [[UIColor purpleColor] setStroke];
  }
}

- (void)drawFaceUp {
  UIBezierPath *path = [self drawShapes];
  [self setColor];
  if(![self.shading isEqualToString:@"open"]) {
    if([self.shading isEqualToString:@"solid"]) {
      [path fill];
    }
    else {
      // striped case
    }
  }
  [path stroke];
}

@end

NS_ASSUME_NONNULL_END
