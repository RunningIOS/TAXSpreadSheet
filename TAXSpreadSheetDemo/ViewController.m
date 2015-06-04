//
//  ViewController.m
//  TAXSpreadSheetDemo
//
//  Created by 金井 慎一 on 2013/10/28.
//  Copyright (c) 2013年 Twelve Axis. All rights reserved.
//

#import "ViewController.h"
#import "TAXSpreadSheet.h"
#import "TAXLabelCell.h"

@interface ViewController () <TAXSpreadSheetDataSource, TAXSpreadSheetDelegate>
{
    IBOutlet TAXSpreadSheet *_spreadSheet;
}
@property (nonatomic, assign) NSUInteger numberOfRows, numberOfColumns;
@property (nonatomic, assign) CGFloat widthOfColumn0;
- (IBAction)insertRowDidTap:(id)sender;
- (IBAction)deleteRowDidTap:(id)sender;
- (IBAction)moveRowDidTap:(id)sender;
- (IBAction)expandColumnDidTap:(id)sender;
- (IBAction)insertColumnDidTap:(id)sender;
@end

static NSString * const CellIdentifier = @"Cell";

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.numberOfRows = 2;
    self.numberOfColumns = 2;
    self.widthOfColumn0 = 20;
    _spreadSheet.interColumnSpacing = 1.0;
    _spreadSheet.interRowSpacing = 1.0;
    [_spreadSheet registerClass:[TAXLabelCell class] forCellWithReuseIdentifier:CellIdentifier];
}
    
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
    
#pragma mark - TAXSpreadSheet DetaSource
    
- (NSUInteger)numberOfColumnsInSpreadSheet:(TAXSpreadSheet *)spreadSheet
{
    return _numberOfColumns;
}
    
- (NSUInteger)numberOfRowsInSpreadSheet:(TAXSpreadSheet *)spreadSheet
{
    return _numberOfRows;
}
    
- (UICollectionViewCell *)spreadSheet:(TAXSpreadSheet *)spreadSheet cellAtRow:(NSUInteger)row column:(NSUInteger)column
{
    TAXLabelCell *cell = (TAXLabelCell *)[_spreadSheet dequeueReusableCellWithReuseIdentifier:CellIdentifier forRow:row column:column];
    cell.backgroundColor = [UIColor whiteColor];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld - %ld", (long)row, (long)column];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}

# pragma mark - TAXSpreadSheet Delegate

- (CGFloat)spreadSheet:(TAXSpreadSheet *)spreadSheet widthAtColumn:(NSUInteger)column
{
    if (column == 0) {
        return _widthOfColumn0;
    } else return NSNotFound;
}

- (void)spreadSheet:(TAXSpreadSheet *)spreadSheet longPressItemAtRow:(NSUInteger)row column:(NSUInteger)column{
    NSLog(@"long press item at row:%@, column:%@", @(row), @(column));
}

# pragma mark - Handler

- (IBAction)insertRowDidTap:(id)sender
{
    self.numberOfRows += 1;
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:0];
    [_spreadSheet insertRows:indexSet];
}

- (IBAction)expandColumnDidTap:(id)sender
{
    self.widthOfColumn0 += 10;
    [_spreadSheet invalidateLayout];
}

- (IBAction)moveRowDidTap:(id)sender
{
    if (self.numberOfRows >= 4) {
        [_spreadSheet moveRow:3 toRow:0];
    }
}

- (IBAction)deleteRowDidTap:(id)sender
{
    if (self.numberOfRows >= 1) {
        self.numberOfRows -= 1;
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:0];
        [_spreadSheet deleteRows:indexSet];
    }
}

- (IBAction)insertColumnDidTap:(id)sender
{
    /*
    NSRange range;
    range.location = 2;
    range.length = 2;
    self.numberOfColumns += range.length;
    
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
     */
    self.numberOfColumns++;
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:0];
    [_spreadSheet insertColumns:indexSet];
}

- (IBAction)deleteColumnDidTap:(id)sender {
    if (self.numberOfColumns >= 1) {
        self.numberOfColumns --;
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:0];
        [_spreadSheet deleteColumns:indexSet];
    }
}

@end
