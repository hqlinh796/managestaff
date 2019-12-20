/**
 * This file is a part of NGrid Framework
 * http://www.nchart3d.com
 *
 * File: NGridSelectionDelegate.h
 * Version: 1.1.33
 *
 * Copyright (C) 2015 Nulana LTD. All Rights Reserved.
 */

#import <UIKit/UIKit.h>

@class NGridSelectionArea;

/**
 * The NGridSelectionDelegate protocol defines callback methods for the selection area.
 */
@protocol NGridSelectionDelegate <NSObject>

/**
 * Called when the selection starts changing.
 * @param selectionArea Selection area.
 */
- (void)selectionWillStartChanging:(NGridSelectionArea *)selectionArea;

/**
 * Called when the selection ends changing.
 * @param selectionArea Selection area.
 */
- (void)selectionDidStopChanging:(NGridSelectionArea *)selectionArea;

/**
 * Called when the selection clean up is needed.
 * @param selectionArea Selection area.
 */
- (void)selectionRequireCleaning:(NGridSelectionArea *)selectionArea;

/**
 * Called when copying of the selected data is needed.
 * @param selectionArea Selection area.
 */
- (void)selectionRequireCopyingData:(NGridSelectionArea *)selectionArea;

@optional

/**
 * Called each time when the selection changes.
 * @param selectionArea Selection area.
 */
- (void)didChangeSelectionArea:(NGridSelectionArea *)selectionArea;

/**
 * Called each time when the selection is tapped.
 * @param selectionArea Selection area.
 */
- (void)didTapSelectionArea:(NGridSelectionArea *)selectionArea;

@end
