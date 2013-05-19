//
//  SpeakersVC.m
//  iOSConf
//
//  Created by Joshua Gretz on 5/18/13.
//  Copyright (c) 2013 TrueFit. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "SpeakersVC.h"
#import "SpeakerRepository.h"
#import "Speaker.h"

@interface SpeakersVC()<UITableViewDataSource, UITableViewDelegate>

@property (strong) SpeakerRepository* speakerRepository;
@property (strong) NSDictionary* speakers;
@property (strong) NSArray* speakerSections;

@end

@implementation SpeakersVC

-(id) init {
    if ((self = [super init]))
        self.title = @"Speakers";

    return self;
}

-(void) viewDidLoad {
    [super viewDidLoad];

    self.speakersTable.layer.cornerRadius = 8;
    self.speakersTable.sectionIndexColor = [UIColor whiteColor];

    [self.speakerRepository when: CLASS_KEYPATH(SpeakerRepository, lastUpdated) changes: ^{
        [self sortSpeakers];
    }];

    [self performBlockInBackground: ^{
        [self sortSpeakers];
    }];
}

-(void) dealloc {
    [self.speakerRepository clearKVOForPath: CLASS_KEYPATH(SpeakerRepository, lastUpdated)];
}

#pragma mark - UITableViewDataSource, UITableViewDelegate
-(NSInteger) numberOfSectionsInTableView: (UITableView*) tableView {
    return self.speakerSections.count;
}

-(NSInteger) tableView: (UITableView*) tableView numberOfRowsInSection: (NSInteger) section {
    return [self.speakers[self.speakerSections[section]] count];
}

-(NSArray*) sectionIndexTitlesForTableView: (UITableView*) tableView {
    return self.speakerSections;
}

-(UITableViewCell*) tableView: (UITableView*) tableView cellForRowAtIndexPath: (NSIndexPath*) indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier: @"CELL"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: @"CELL"];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.numberOfLines = 0;

        UIImageView* background = [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, 300, 66)];
        background.image = [UIImage imageNamed: @"cellbackground.png"];
        [cell.contentView addSubview: background];
        [cell.contentView sendSubviewToBack: background];
    }

    Speaker* speaker = self.speakers[self.speakerSections[indexPath.section]][indexPath.row];

    cell.textLabel.text = speaker.name;

    return cell;
}

-(CGFloat) tableView: (UITableView*) tableView heightForRowAtIndexPath: (NSIndexPath*) indexPath {
    return 66;
}

-(void) tableView: (UITableView*) tableView didSelectRowAtIndexPath: (NSIndexPath*) indexPath {
    [tableView deselectRowAtIndexPath: indexPath animated: NO];

}

#pragma mark - Sort Sessions
-(void) sortSpeakers {
    NSMutableSet* speakerSet = [NSMutableSet set];
    NSMutableDictionary* speakers = [NSMutableDictionary dictionary];

    for (Speaker* speaker in self.speakerRepository.data) {
        NSString* key = [speaker.name substring: 1 start: 0];

        [speakerSet addObject: key];

        NSMutableArray* array = speakers[key];
        if (!array)
            speakers[key] = array = [NSMutableArray array];

        [array addObject: speaker];
    }

    NSArray* sortedArray = [speakerSet.allObjects sortedArrayUsingComparator: ^NSComparisonResult(NSString* obj1, NSString* obj2) {
        return [obj1 compare: obj2];
    }];

    for (NSString* key in self.speakers) {
        [speakers[key] sortUsingComparator: ^NSComparisonResult(Speaker* obj1, Speaker* obj2) {
            return [obj1.name compare: obj2.name];
        }];
    }

    [self performBlockInMainThread: ^{
        if (self.activityIndicator.isAnimating)
            [self.activityIndicator stopAnimating];

        @synchronized (self) {
            self.speakerSections = sortedArray;
            self.speakers = speakers;

            [self.speakersTable reloadData];
            [self.speakersTable scrollToRowAtIndexPath: [NSIndexPath indexPathForRow: 0 inSection: 0] atScrollPosition: UITableViewScrollPositionTop animated: NO];
        }
    }];
}

@end
