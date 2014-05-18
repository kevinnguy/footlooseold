//
//  FLMessageViewController.m
//  Footloose
//
//  Created by kevin on 5/17/14.
//  Copyright (c) 2014 kevinnguy. All rights reserved.
//

#import "FLMessageViewController.h"

#import "FLContactTableViewController.h"

#import <JSQMessagesViewController/JSQMessages.h>
#import <SlideNavigationController.h>


@interface FLMessageViewController () <SlideNavigationControllerDelegate, FLContactTableViewDelegate>
@property (nonatomic, strong) NSString *recipient;
@property (nonatomic, strong) UIImage *recipientImage;

@property (strong, nonatomic) NSMutableArray *messages;
@property (copy, nonatomic) NSDictionary *avatars;

@property (strong, nonatomic) UIImageView *outgoingBubbleImageView;
@property (strong, nonatomic) UIImageView *incomingBubbleImageView;
@end

@implementation FLMessageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.sender = @"Kevin Nguy";
    self.recipient = @"Tim Cook";
    self.recipientImage = [UIImage imageNamed:@"demo_avatar_cook"];
    self.title = self.recipient;
    
    FLContactTableViewController *contactTableViewController = (FLContactTableViewController *)[SlideNavigationController sharedInstance].leftMenu;
    contactTableViewController.delegate = self;
    
    [self setupTestModel];
    
    /**
     *  Remove camera button since media messages are not yet implemented
     *
     *   self.inputToolbar.contentView.leftBarButtonItem = nil;
     *
     *  Or, you can set a custom `leftBarButtonItem` and a custom `rightBarButtonItem`
     */
    

    self.outgoingBubbleImageView = [JSQMessagesBubbleImageFactory
                                    outgoingMessageBubbleImageViewWithColor:[UIColor jsq_messageBubbleLightGrayColor]];
    
    self.incomingBubbleImageView = [JSQMessagesBubbleImageFactory
                                    incomingMessageBubbleImageViewWithColor:[UIColor jsq_messageBubbleGreenColor]];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeInfoLight];
    [button addTarget:self action:@selector(rightBarButtonItemPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)rightBarButtonItemPressed:(id)sender
{
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    self.collectionView.collectionViewLayout.springinessEnabled = NO;
}

- (void)setupTestModel
{
    self.title = self.recipient;
    
    CGFloat outgoingDiameter = self.collectionView.collectionViewLayout.outgoingAvatarViewSize.width;
    UIImage *senderImage = [JSQMessagesAvatarFactory avatarWithImage:[UIImage imageNamed:@"kevin"]
                                                            diameter:outgoingDiameter];
    
    CGFloat incomingDiameter = self.collectionView.collectionViewLayout.incomingAvatarViewSize.width;
    UIImage *recipientImage = [JSQMessagesAvatarFactory avatarWithImage:self.recipientImage
                                                               diameter:incomingDiameter];
    
    self.avatars = @{ self.sender : senderImage,
                      self.recipient : recipientImage };
    
    self.messages = [[NSMutableArray alloc] initWithObjects:
                     [[JSQMessage alloc] initWithText:@"Welcome to JSQMessages: A messaging UI framework for iOS." sender:self.sender date:[NSDate distantPast]],
                     [[JSQMessage alloc] initWithText:@"It is simple, elegant, and easy to use. There are super sweet default settings, but you can customize like crazy." sender:self.recipient date:[NSDate distantPast]],
                     [[JSQMessage alloc] initWithText:@"It even has data detectors. You can call me tonight. My cell number is 123-456-7890. My website is www.hexedbits.com." sender:self.sender date:[NSDate distantPast]],
                     [[JSQMessage alloc] initWithText:@"JSQMessagesViewController is nearly an exact replica of the iOS Messages App. And perhaps, better." sender:self.recipient date:[NSDate date]],
                     [[JSQMessage alloc] initWithText:@"It is unit-tested, free, and open-source." sender:self.recipient date:[NSDate date]],
                     [[JSQMessage alloc] initWithText:@"Oh, and there's sweet documentation." sender:self.sender date:[NSDate date]],
                     [[JSQMessage alloc] initWithText:@"Welcome to JSQMessages: A messaging UI framework for iOS." sender:self.sender date:[NSDate distantPast]],
                     [[JSQMessage alloc] initWithText:@"It is simple, elegant, and easy to use. There are super sweet default settings, but you can customize like crazy." sender:self.recipient date:[NSDate distantPast]],
                     [[JSQMessage alloc] initWithText:@"It even has data detectors. You can call me tonight. My cell number is 123-456-7890. My website is www.hexedbits.com." sender:self.sender date:[NSDate distantPast]],
                     [[JSQMessage alloc] initWithText:@"JSQMessagesViewController is nearly an exact replica of the iOS Messages App. And perhaps, better." sender:self.recipient date:[NSDate date]],
                     [[JSQMessage alloc] initWithText:@"It is unit-tested, free, and open-source." sender:self.recipient date:[NSDate date]],
                     [[JSQMessage alloc] initWithText:@"Oh, and there's sweet documentation." sender:self.sender date:[NSDate date]],
                     [[JSQMessage alloc] initWithText:@"Welcome to JSQMessages: A messaging UI framework for iOS." sender:self.sender date:[NSDate distantPast]],
                     [[JSQMessage alloc] initWithText:@"It is simple, elegant, and easy to use. There are super sweet default settings, but you can customize like crazy." sender:self.recipient date:[NSDate distantPast]],
                     [[JSQMessage alloc] initWithText:@"It even has data detectors. You can call me tonight. My cell number is 123-456-7890. My website is www.hexedbits.com." sender:self.sender date:[NSDate distantPast]],
                     [[JSQMessage alloc] initWithText:@"JSQMessagesViewController is nearly an exact replica of the iOS Messages App. And perhaps, better." sender:self.recipient date:[NSDate date]],
                     [[JSQMessage alloc] initWithText:@"It is unit-tested, free, and open-source." sender:self.recipient date:[NSDate date]],
                     [[JSQMessage alloc] initWithText:@"Oh, and there's sweet documentation." sender:self.sender date:[NSDate date]],
                     nil];
}

#pragma mark - JSQMessagesViewController method overrides

- (void)didPressSendButton:(UIButton *)button
           withMessageText:(NSString *)text
                    sender:(NSString *)sender
                      date:(NSDate *)date
{
    /**
     *  Sending a message. Your implementation of this method should do *at least* the following:
     *
     *  1. Play sound (optional)
     *  2. Add new id<JSQMessageData> object to your data source
     *  3. Call `finishSendingMessage`
     */
    [JSQSystemSoundPlayer jsq_playMessageSentSound];
    
    JSQMessage *message = [[JSQMessage alloc] initWithText:text sender:sender date:date];
    [self.messages addObject:message];
    
    [self finishSendingMessage];
}

- (void)didPressAccessoryButton:(UIButton *)sender
{
    NSLog(@"Camera pressed!");

    self.showTypingIndicator = !self.showTypingIndicator;
    
    JSQMessage *copyMessage = [[self.messages lastObject] copy];
    
    if (!copyMessage) {
        return;
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSMutableArray *copyAvatars = [[self.avatars allKeys] mutableCopy];
        [copyAvatars removeObject:self.sender];
        copyMessage.sender = [copyAvatars objectAtIndex:arc4random_uniform((int)[copyAvatars count])];
        
        /**
         *  This you should do upon receiving a message:
         *
         *  1. Play sound (optional)
         *  2. Add new id<JSQMessageData> object to your data source
         *  3. Call `finishReceivingMessage`
         */
        [JSQSystemSoundPlayer jsq_playMessageReceivedSound];
        [self.messages addObject:copyMessage];
        [self finishReceivingMessage];
    });
}



#pragma mark - JSQMessages CollectionView DataSource

- (id<JSQMessageData>)collectionView:(JSQMessagesCollectionView *)collectionView messageDataForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.messages objectAtIndex:indexPath.item];
}

- (UIImageView *)collectionView:(JSQMessagesCollectionView *)collectionView bubbleImageViewForItemAtIndexPath:(NSIndexPath *)indexPath
{
    /**
     *  You may return nil here if you do not want bubbles.
     *  In this case, you should set the background color of your collection view cell's textView.
     */
    
    /**
     *  Reuse created bubble images, but create new imageView to add to each cell
     *  Otherwise, each cell would be referencing the same imageView and bubbles would disappear from cells
     */
    
    JSQMessage *message = [self.messages objectAtIndex:indexPath.item];
    
    if ([message.sender isEqualToString:self.sender]) {
        return [[UIImageView alloc] initWithImage:self.outgoingBubbleImageView.image
                                 highlightedImage:self.outgoingBubbleImageView.highlightedImage];
    }
    
    return [[UIImageView alloc] initWithImage:self.incomingBubbleImageView.image
                             highlightedImage:self.incomingBubbleImageView.highlightedImage];
}

- (UIImageView *)collectionView:(JSQMessagesCollectionView *)collectionView avatarImageViewForItemAtIndexPath:(NSIndexPath *)indexPath
{
    /**
     *  Return `nil` here if you do not want avatars.
     *  If you do return `nil`, be sure to do the following in `viewDidLoad`:
     *
     *  self.collectionView.collectionViewLayout.incomingAvatarViewSize = CGSizeZero;
     *  self.collectionView.collectionViewLayout.outgoingAvatarViewSize = CGSizeZero;
     *
     *  It is possible to have only outgoing avatars or only incoming avatars, too.
     */
    
    /**
     *  Reuse created avatar images, but create new imageView to add to each cell
     *  Otherwise, each cell would be referencing the same imageView and avatars would disappear from cells
     *
     *  Note: these images will be sized according to these values:
     *
     *  self.collectionView.collectionViewLayout.incomingAvatarViewSize
     *  self.collectionView.collectionViewLayout.outgoingAvatarViewSize
     *
     *  Override the defaults in `viewDidLoad`
     */
    JSQMessage *message = [self.messages objectAtIndex:indexPath.item];
    
    UIImage *avatarImage = [self.avatars objectForKey:message.sender];
    return [[UIImageView alloc] initWithImage:avatarImage];
}

- (NSAttributedString *)collectionView:(JSQMessagesCollectionView *)collectionView attributedTextForCellTopLabelAtIndexPath:(NSIndexPath *)indexPath
{
    /**
     *  This logic should be consistent with what you return from `heightForCellTopLabelAtIndexPath:`
     *  The other label text delegate methods should follow a similar pattern.
     *
     *  Show a timestamp for every 3rd message
     */
    if (indexPath.item % 3 == 0) {
        JSQMessage *message = [self.messages objectAtIndex:indexPath.item];
        return [[JSQMessagesTimestampFormatter sharedFormatter] attributedTimestampForDate:message.date];
    }
    
    return nil;
}

- (NSAttributedString *)collectionView:(JSQMessagesCollectionView *)collectionView attributedTextForMessageBubbleTopLabelAtIndexPath:(NSIndexPath *)indexPath
{
//    JSQMessage *message = [self.messages objectAtIndex:indexPath.item];
//    
//    /**
//     *  iOS7-style sender name labels
//     */
//    if ([message.sender isEqualToString:self.sender]) {
//        return nil;
//    }
//    
//    if (indexPath.item - 1 > 0) {
//        JSQMessage *previousMessage = [self.messages objectAtIndex:indexPath.item - 1];
//        if ([[previousMessage sender] isEqualToString:message.sender]) {
//            return nil;
//        }
//    }
//    
//    /**
//     *  Don't specify attributes to use the defaults.
//     */
//    return [[NSAttributedString alloc] initWithString:message.sender];
    return nil;
}

- (NSAttributedString *)collectionView:(JSQMessagesCollectionView *)collectionView attributedTextForCellBottomLabelAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

#pragma mark - UICollectionView DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.messages count];
}

- (UICollectionViewCell *)collectionView:(JSQMessagesCollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    /**
     *  Override point for customizing cells
     */
    JSQMessagesCollectionViewCell *cell = (JSQMessagesCollectionViewCell *)[super collectionView:collectionView cellForItemAtIndexPath:indexPath];
    
    /**
     *  Configure almost *anything* on the cell
     *
     *  Text colors, label text, label colors, etc.
     *
     *
     *  DO NOT set `cell.textView.font` !
     *  Instead, you need to set `self.collectionView.collectionViewLayout.messageBubbleFont` to the font you want in `viewDidLoad`
     *
     *
     *  DO NOT manipulate cell layout information!
     *  Instead, override the properties you want on `self.collectionView.collectionViewLayout` from `viewDidLoad`
     */
    
    JSQMessage *msg = [self.messages objectAtIndex:indexPath.item];
    
    if ([msg.sender isEqualToString:self.sender]) {
        cell.textView.textColor = [UIColor blackColor];
    }
    else {
        cell.textView.textColor = [UIColor whiteColor];
    }
    
    cell.textView.linkTextAttributes = @{ NSForegroundColorAttributeName : cell.textView.textColor,
                                          NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle | NSUnderlinePatternSolid) };
    
    return cell;
}


#pragma mark - JSQMessages collection view flow layout delegate

- (CGFloat)collectionView:(JSQMessagesCollectionView *)collectionView
                   layout:(JSQMessagesCollectionViewFlowLayout *)collectionViewLayout heightForCellTopLabelAtIndexPath:(NSIndexPath *)indexPath
{
    /**
     *  Each label in a cell has a `height` delegate method that corresponds to its text dataSource method
     */
    
    /**
     *  This logic should be consistent with what you return from `attributedTextForCellTopLabelAtIndexPath:`
     *  The other label height delegate methods should follow similarly
     *
     *  Show a timestamp for every 3rd message
     */
    if (indexPath.item % 3 == 0) {
        return kJSQMessagesCollectionViewCellLabelHeightDefault;
    }
    
    return 10.0f;
}

- (CGFloat)collectionView:(JSQMessagesCollectionView *)collectionView
                   layout:(JSQMessagesCollectionViewFlowLayout *)collectionViewLayout heightForMessageBubbleTopLabelAtIndexPath:(NSIndexPath *)indexPath
{
    /**
     *  iOS7-style sender name labels
     */
    JSQMessage *currentMessage = [self.messages objectAtIndex:indexPath.item];
    if ([[currentMessage sender] isEqualToString:self.sender]) {
        return 0.0f;
    }
    
    if (indexPath.item - 1 > 0) {
        JSQMessage *previousMessage = [self.messages objectAtIndex:indexPath.item - 1];
        if ([[previousMessage sender] isEqualToString:[currentMessage sender]]) {
            return 0.0f;
        }
    }
    
    return kJSQMessagesCollectionViewCellLabelHeightDefault;
}

- (CGFloat)collectionView:(JSQMessagesCollectionView *)collectionView
                   layout:(JSQMessagesCollectionViewFlowLayout *)collectionViewLayout heightForCellBottomLabelAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 0.0f;
}

- (void)collectionView:(JSQMessagesCollectionView *)collectionView
                header:(JSQMessagesLoadEarlierHeaderView *)headerView didTapLoadEarlierMessagesButton:(UIButton *)sender
{
    NSLog(@"Load earlier messages!");
}

#pragma mark - SlideNavigationControllerDelegate
- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
	return YES;
}

#pragma mark - FLContactTableViewDelegate
- (void)didSelectContact:(NSString *)contactName image:(UIImage *)image
{
    self.recipient = contactName;
    self.recipientImage = image;
    [self setupTestModel];
    [self.collectionView reloadData];
    [[SlideNavigationController sharedInstance] closeMenuWithCompletion:nil];
    [self scrollToBottomAnimated:YES];
}

@end
