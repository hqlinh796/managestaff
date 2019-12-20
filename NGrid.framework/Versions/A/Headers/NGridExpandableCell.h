/**
 * This file is a part of NGrid Framework
 * http://www.nchart3d.com
 *
 * File: NGridExpandableCell.h
 * Version: 1.1.33
 *
 * Copyright (C) 2015 Nulana LTD. All Rights Reserved.
 */

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "NGridImageTextCell.h"

/**
 * The NGridExpandableCell class defines attributes and behavior of the expandable cells.
 * This class implements all supported cell functionality and used in default proxy grid data source <NGridProxyDataSourceImpl>.
 */
@interface NGridExpandableCell : NGridImageTextCell

/**
 * A Boolean value that determines whether the cell should be used as expander for rows.
 *
 * If YES, shows expander and catches touches on the expander icon.
 */
@property (nonatomic, assign) BOOL isExpandableRow;

/**
 * A Boolean value that determines whether the cell should be used as expander for columns.
 *
 * If YES, shows expander and catches touches on expander icon.
 */
@property (nonatomic, assign) BOOL isExpandableColumn;

/**
 * A Boolean value that determines whether the cell is expanded.
 *
 * If YES, show expanded expander icon, otherwise collapsed.
 */
@property (nonatomic, assign) BOOL isExpanded;

/**
 * A Boolean value that determines whether the last touch was on the expander icon.
 */
@property (assign) BOOL isExpandIconTouched;

@end
