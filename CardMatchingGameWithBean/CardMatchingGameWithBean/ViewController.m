//
//  ViewController.m
//  CardMatchingGameWithBean
//
//  Created by Nadine Hachouche on 12/22/15.
//  Copyright © 2015 nadine farah. All rights reserved.
//

#import "ViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"
#import "Card.h"
#import "CardMatchingGame.h"

@interface ViewController ()



@property(strong, nonatomic) PlayingCardDeck *deck;
@property(nonatomic) CardMatchingGame* game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@end

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}



-(PlayingCardDeck *)deck
{
    if (!(_deck)) {
        _deck = [[PlayingCardDeck alloc] init];
    }
    return _deck;
}


-(CardMatchingGame *) game{
    if (! _game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                           usingDeck:[self deck]];
    return _game;
}


- (IBAction)touchCardButton:(UIButton *)sender
{

    NSUInteger cardIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:cardIndex];
    [self updateUI];


}

-(void)updateUI
{
    for (UIButton* cardButton in self.cardButtons){
        NSInteger cardIndex = [self.cardButtons indexOfObject:cardButton]; //cardButton is a card object
        Card *card = [self.game cardAtIndex:cardIndex];
        
        
        [cardButton setTitle: [self titleForCard:card] forState: UIControlStateNormal];
        [cardButton setBackgroundImage: [self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", self.game.score];
    }
}


-(NSString*) titleForCard: (Card *) card
{
    return card.isChosen ? card.contents : @"";
}

-(UIImage*) backgroundImageForCard: (Card *) card
{
    return [UIImage imageNamed:(card.isChosen) ? @"plainCard" : @"pt-back-card.png"];
}



@end
