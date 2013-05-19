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
#import "SpeakerVC.h"

@interface SpeakersVC()<UITableViewDataSource, UITableViewDelegate>

@property (strong) UISegmentedControl* sortSegmentedControl;
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

    self.navigationItem.titleView = [self createSortSegmentedControl];

    self.speakersTable.layer.cornerRadius = 8;
    self.speakersTable.sectionIndexColor = [UIColor whiteColor];

    [self.speakerRepository when: CLASS_KEYPATH(SpeakerRepository, lastUpdated) changes: ^{
        [self sortSpeakers];
    }];

    [self performBlockInBackground: ^{
        [self sortSpeakers];
    }];
}

-(UISegmentedControl*) createSortSegmentedControl {
    self.sortSegmentedControl = [[UISegmentedControl alloc] initWithItems: @[ @"First Name", @"Last Name" ]];
    self.sortSegmentedControl.selectedSegmentIndex = 0;
    self.sortSegmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
    self.sortSegmentedControl.tintColor = self.navigationController.navigationBar.tintColor;

    [self.sortSegmentedControl addTarget: self action: @selector(sortSpeakers) forControlEvents: UIControlEventValueChanged];

    return self.sortSegmentedControl;
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

    SpeakerVC* vc = [SpeakerVC object];
    vc.speaker = self.speakers[self.speakerSections[indexPath.section]][indexPath.row];

    [self.navigationController pushViewController: vc animated: YES];
}

#pragma mark - Sort Sessions
-(void) sortSpeakers {
    NSMutableSet* speakerSet = [NSMutableSet set];
    NSMutableDictionary* speakers = [NSMutableDictionary dictionary];

    NSString*(^getSort)(NSString*) = ^(NSString* value) {
        NSArray* split = [value componentsSeparatedByString: @" "];

        switch (self.sortSegmentedControl.selectedSegmentIndex) {
            case 0:
                return (NSString*) split[0];

            case 1:
                return (NSString*) split[split.count - 1];
        }

        return value;
    };

    for (Speaker* speaker in self.speakerRepository.data) {
        NSString* key = [[getSort(speaker.name) substring: 1 start: 0] uppercaseString];

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
            NSComparisonResult result = [getSort(obj1.name) compare: getSort(obj2.name)];
            if (result != NSOrderedSame)
                return result;

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
