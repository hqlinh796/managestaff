/**
 * This file is a part of NGrid Framework
 * http://www.nchart3d.com
 *
 * File: NGridTextCell.h
 * Version: 1.1.33
 *
 * Copyright (C) 2015 Nulana LTD. All Rights Reserved.
 */

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "NGridDecoratedCell.h"

/**
 * The NGridTextCell class provides decorated cell with the text inside.
 */
@interface NGridTextCell : NGridDecoratedCell

/**
 * Text displayed by the cell.
 */
@property (nonatomic, retain) NSString *text;

@end
