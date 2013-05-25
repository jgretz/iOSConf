//
// Created by Joshua Gretz on 5/14/13.
// Copyright (c) 2013 TrueFit. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//

#import <QuartzCore/QuartzCore.h>
#import "SessionsVC.h"
#import "SessionRepository.h"
#import "SessionDisplayService.h"
#import "SessionVC.h"

@interface SessionsVC()<UITableViewDataSource, UITableViewDelegate>

@property (strong) UISegmentedControl* sortSegmentedControl;

@property (strong) NSArray* sectionTitles;
@property (strong) NSDictionary* sessions;

@end

@implementation SessionsVC

-(id) init {
    if ((self = [super init]))
        self.title = @"Sessions";

    return self;
}

-(void) viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.titleView = [self createSortSegmentedControl];

    self.sessionsTable.layer.cornerRadius = 8;

    [self.sessionRepository when: CLASS_KEYPATH(SessionRepository, lastUpdated) changes: ^{
        [self sortSessions];
    }];

    [self performBlockInBackground: ^{
        [self sortSessions];
    }];
}

-(UISegmentedControl*) createSortSegmentedControl {
    self.sortSegmentedControl = [[UISegmentedControl alloc] initWithItems: @[ @"Time", @"Track", @"Name" ]];
    self.sortSegmentedControl.selectedSegmentIndex = 0;
    self.sortSegmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
    self.sortSegmentedControl.tintColor = self.navigationController.navigationBar.tintColor;

    [self.sortSegmentedControl addTarget: self action: @selector(sortSessions) forControlEvents: UIControlEventValueChanged];

    return self.sortSegmentedControl;
}

-(void) dealloc {
    [self.sessionRepository clearKVOForPath: CLASS_KEYPATH(SessionRepository, lastUpdated)];
}

#pragma mark - UITableViewDataSource, UITableViewDelegate
-(NSInteger) numberOfSectionsInTableView: (UITableView*) tableView {
    return self.sessions.count;
}

-(NSInteger) tableView: (UITableView*) tableView numberOfRowsInSection: (NSInteger) section {
    return [self.sessions[self.sectionTitles[(NSUInteger) section]] count];
}

-(UITableViewCell*) tableView: (UITableView*) tableView cellForRowAtIndexPath: (NSIndexPath*) indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier: @"CELL"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleValue2 reuseIdentifier: @"CELL"];
        cell.textLabel.numberOfLines = 4;
        cell.textLabel.font = [UIFont systemFontOfSize: 10];
        cell.textLabel.textColor = [UIColor blackColor];

        cell.detailTextLabel.numberOfLines = 4;
        cell.detailTextLabel.textColor = [UIColor whiteColor];
    }

    Session* session = self.sessions[self.sectionTitles[(NSUInteger) indexPath.section]][(NSUInteger) indexPath.row];

    // build detail
    NSString* detail = [self.sessionDisplayService buildDetailForSession: session forGrouping: (SessionGrouping) self.sortSegmentedControl.selectedSegmentIndex];

    cell.textLabel.text = detail;
    cell.detailTextLabel.text = session.title;

    return cell;
}

-(UIView*) tableView: (UITableView*) tableView viewForHeaderInSection: (NSInteger) section {
    UIView* header = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 320, 20)];
    header.backgroundColor = [UIColor brownColor];

    UILabel* label = [[UILabel alloc] initWithFrame: CGRectMake(10, 4, 300, 15)];
    label.font = [UIFont fontWithName: @"Helvetica-Bold" size: 16];
    label.text = self.sectionTitles[(NSUInteger) section];
    label.backgroundColor = [UIColor brownColor];
    label.textColor = [UIColor whiteColor];

    [header addSubview: label];

    return header;
}

-(CGFloat) tableView: (UITableView*) tableView heightForRowAtIndexPath: (NSIndexPath*) indexPath {
    return 88;
}

-(void) tableView: (UITableView*) tableView didSelectRowAtIndexPath: (NSIndexPath*) indexPath {
    [tableView deselectRowAtIndexPath: indexPath animated: NO];

    SessionVC* vc = [SessionVC object];
    vc.session = self.sessions[self.sectionTitles[(NSUInteger) indexPath.section]][(NSUInteger) indexPath.row];

    [self.navigationController pushViewController: vc animated: YES];
}

#pragma mark - Sort Sessions
-(void) sortSessions {
    NSArray* sectionTitles;
    NSDictionary* sessions;

    [self.sessionDisplayService fillAndSortSectionTitles: &sectionTitles andSessions: &sessions forGrouping: (SessionGrouping) self.sortSegmentedControl.selectedSegmentIndex];

    [self performBlockInMainThread: ^{
        if (self.activityIndicator.isAnimating)
            [self.activityIndicator stopAnimating];

        @synchronized (self) {
            self.sectionTitles = sectionTitles;
            self.sessions = sessions;

            [self.sessionsTable reloadData];

            if (sessions.count > 0)
                [self.sessionsTable scrollToRowAtIndexPath: [NSIndexPath indexPathForRow: 0 inSection: 0] atScrollPosition: UITableViewScrollPositionTop animated: NO];
        }
    }];
}

@end