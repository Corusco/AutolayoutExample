//
//  AETableViewCell.m
//  AutolayoutExample
//
//  Created by Ben Norris on 10/2/14.
//  Copyright (c) 2014 BSN Design. All rights reserved.
//

#import "AETableViewCell.h"

@implementation AETableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    self.photoButton = [UIButton new];
    [self.photoButton setTitle:@"Add" forState:UIControlStateNormal];
    [self.photoButton setTintColor:[UIColor whiteColor]];
    [self.photoButton setBackgroundColor:[UIColor blueColor]];
    self.photoButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:self.photoButton];
    
    self.nameField = [UITextField new];
    self.nameField.borderStyle = UITextBorderStyleRoundedRect;
    [self.contentView addSubview:self.nameField];
    
    self.scoreField = [UITextField new];
    self.scoreField.borderStyle = UITextBorderStyleRoundedRect;
    [self.contentView addSubview:self.scoreField];
    
    self.scoreStepper = [UIStepper new];
    [self.contentView addSubview:self.scoreStepper];
    
    // CONSTRAINTS
    
    // Turn off Autoresizing Mask Layout Constraints that are on by default
    [self.photoButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.nameField setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.scoreField setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.scoreStepper setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    // Make a dictionary of all the views you need to lay out
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_photoButton, _nameField, _scoreField, _scoreStepper);
    
    // Space everything out by default spaces with flexible space between score and stepper with min width on name and score
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_photoButton]-[_nameField(>=95)]-[_scoreField(>=40)]-(>=8)-[_scoreStepper]-|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:viewsDictionary];

    // Add the constraint to the common ancestor of all the views you want to lay out
    [self.contentView addConstraints:constraints];
    
    // Try to center the score
    NSLayoutConstraint *actualScoreCenterConstraint =
    [NSLayoutConstraint constraintWithItem:_scoreField
                                 attribute:NSLayoutAttributeCenterX
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.contentView
                                 attribute:NSLayoutAttributeCenterX
                                multiplier:1.0
                                  constant:0.0];
    actualScoreCenterConstraint.priority = UILayoutPriorityDefaultHigh;
    [self.contentView addConstraint:actualScoreCenterConstraint];
    
    // Stretch the photo button to the available height of the row, thus centering everything vertically
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_photoButton]-|" options:0 metrics:nil views:viewsDictionary];
    [self.contentView addConstraints:constraints];
    
    // Make the photo button 1:1
    NSLayoutConstraint *photoButtonAspectRatioConstraint =
    [NSLayoutConstraint constraintWithItem:_photoButton
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:_photoButton
                                 attribute:NSLayoutAttributeHeight
                                multiplier:1.0
                                  constant:0];
    [self.photoButton addConstraint:photoButtonAspectRatioConstraint];
    
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    self.photoButton.layer.cornerRadius = self.photoButton.frame.size.width / 2;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
