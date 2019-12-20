/**
 * This file is a part of NGrid Framework
 * http://www.nchart3d.com
 *
 * File: NGridStyleManager.h
 * Version: 1.1.33
 *
 * Copyright (C) 2015 Nulana LTD. All Rights Reserved.
 */

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "NGridStyleLevel.h"

/**
 * Options used to specify the style level order.
 * Styles from the top levels overlap styles from the bottom ones by merging. It means if you set
 * font size and font color properties in style from level 0 and set only font color property in style from level 1
 * then in the grid you will see cells with font size from level 0 and font color from level 1.
 *
 */
typedef NS_ENUM(NSInteger, NGridStyleLevelOrder) {
    /**
     * Level 0 contains back (or background) styles.
     */
    NGridStyleLevelOrderLevel0 = 0,
    
    /**
     * Level 1 styles overlap style from level 0.
     */
    NGridStyleLevelOrderLevel1,
    
    /**
     * Level 2 styles overlap style from level 1 and 0.
     */
    NGridStyleLevelOrderLevel2
};

/**
 * The NGridStyleManager class is used to manage grid styles.
 */
@interface NGridStyleManager : NSObject <NSCoding>

/**
 * Returns style level.
 * @param levelOrder Order of the level.
 */
- (NGridStyleLevel *)styleLevel:(NGridStyleLevelOrder)levelOrder;

/**
 * Returns assembled style for the cell.
 * This method finds all appropriate styles for the cell in all levels and merges them into result style.
 * @param cellKey Key of the cell.
 */
- (NGridCellStyle *)styleForCellWithKey:(NGridCellKey *)cellKey;

/**
 * Removes all styles from all levels.
 */
- (void)removeAllStyles;

@end
