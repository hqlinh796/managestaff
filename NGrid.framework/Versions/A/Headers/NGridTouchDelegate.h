/**
 * This file is a part of NGrid Framework
 * http://www.nchart3d.com
 *
 * File: NGridTouchDelegate.h
 * Version: 1.1.33
 *
 * Copyright (C) 2015 Nulana LTD. All Rights Reserved.
 */

#import <UIKit/UIKit.h>

@class NGridCell;

/**
 * The NGridTouchDelegate protocol provides delegate for touch handling in the grid view.
 */
@protocol NGridTouchDelegate <NSObject>

/**
 * Called when touches began in the given cell.
 * @param gridView Related grid view object.
 * @param touches Set of touches.
 * @param event Event.
 * @param cell Touched cell.
 */
- (void)gridView:(NGridView *)gridView touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event inCell:(NGridCell *)cell;

/**
 * Called when touches ended in the given cell.
 * @param gridView Related grid view object.
 * @param touches Set of touches.
 * @param event Event.
 * @param cell Touched cell.
 */
- (void)gridView:(NGridView *)gridView touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event inCell:(NGridCell *)cell;

/**
 * Called when touches are cancelled in the given cell.
 * @param gridView Related grid view object.
 * @param touches Set of touches.
 * @param event Event.
 * @param cell Touched cell.
 */
- (void)gridView:(NGridView *)gridView touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event inCell:(NGridCell *)cell;

/**
 * Called when touches moved in the given cell.
 * @param gridView Related grid view object.
 * @param touches Set of touches.
 * @param event Event.
 * @param cell Touched cell.
 */
- (void)gridView:(NGridView *)gridView touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event inCell:(NGridCell *)cell;

@optional

/**
 * Called when the single tap is recognized in the given cell.
 * @param gridView Related grid view object.
 * @param cell Related cell.
 * @param recognizer Recognizer that recognized the tap.
 */
- (void)gridView:(NGridView *)gridView didTapCell:(NGridCell *)cell fromRecognizer:(UIGestureRecognizer *)recognizer;

/**
 * Called when the double tap is recognized in the given cell.
 * @param gridView Related grid view object.
 * @param cell Related cell.
 * @param recognizer Recognizer that recognized the double tap.
 */
- (void)gridView:(NGridView *)gridView didDoubleTapCell:(NGridCell *)cell fromRecognizer:(UIGestureRecognizer *)recognizer;

/**
 * Called when the long tap is recognized in the given cell.
 * @param gridView Related grid view object.
 * @param cell Related cell.
 * @param recognizer Recognizer that recognized the long tap.
 */
- (void)gridView:(NGridView *)gridView didLongTapCell:(NGridCell *)cell fromRecognizer:(UIGestureRecognizer *)recognizer;

@end
