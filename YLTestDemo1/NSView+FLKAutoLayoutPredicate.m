//
// Created by florian on 26.03.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "NSView+FLKAutoLayoutPredicate.h"

FLKAutoLayoutPredicate FLKAutoLayoutPredicateMake(NSLayoutRelation relation, CGFloat multiplier, CGFloat constant, NSLayoutPriority priority) {
    FLKAutoLayoutPredicate predicate;
    predicate.relation = relation;
    predicate.multiplier = multiplier;
    predicate.constant = constant;
    predicate.priority = priority;
    return predicate;
}


@implementation FLK_VIEW (FLKAutoLayoutPredicate)


- (NSLayoutConstraint*)applyPredicate:(FLKAutoLayoutPredicate)predicate toView:(FLK_VIEW*)toView attribute:(NSLayoutAttribute)attribute {
    return [self applyPredicate:predicate toView:toView fromAttribute:attribute toAttribute:attribute];
}

- (NSLayoutConstraint*)applyPredicate:(FLKAutoLayoutPredicate)predicate toView:(FLK_VIEW*)view fromAttribute:(NSLayoutAttribute)fromAttribute toAttribute:(NSLayoutAttribute)toAttribute {
    if (predicate.priority > NSLayoutPriorityRequired) return nil;

    FLK_VIEW* commonSuperview = [self commonSuperviewWithView:view];
    self.translatesAutoresizingMaskIntoConstraints = NO;

    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self
                                              attribute:fromAttribute
                                              relatedBy:predicate.relation
                                                 toItem:view
                                              attribute:toAttribute
                                             multiplier:predicate.multiplier
                                               constant:predicate.constant];
    if (predicate.priority) {
        constraint.priority = predicate.priority;
    }
    [commonSuperview addConstraint:constraint];

    return constraint;
}

- (FLK_VIEW*)commonSuperviewWithView:(FLK_VIEW*)view {
    if (!view) {
        return self;
    } else if (self.superview == view) {
        return view;
    } else if (self == view.superview) {
        return self;
    } else if (self.superview == view.superview) {
        return self.superview;
    } else {
        FLK_VIEW* commonSuperview = [self traverseViewTreeForCommonSuperViewWithView:view];
        NSAssert(commonSuperview, @"Cannot find common superview of %@ and %@. Did you forget to call addSubview: before adding constraints?", self, view);
        return commonSuperview;
    }
}

- (FLK_VIEW*)traverseViewTreeForCommonSuperViewWithView:(FLK_VIEW*)view {
    NSMutableOrderedSet* selfSuperviews = [NSMutableOrderedSet orderedSet];
    FLK_VIEW* selfSuperview = self;
    while (selfSuperview) {
        [selfSuperviews addObject:selfSuperview];
        selfSuperview = selfSuperview.superview;
    }
    FLK_VIEW* superview = view;
    while (superview) {
        if ([selfSuperviews containsObject:superview]) {
            return superview;
        }
        superview = superview.superview;
    }
    return nil;
}

@end
