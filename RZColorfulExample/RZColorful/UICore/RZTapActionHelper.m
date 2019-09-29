//
//  RZTapActionHelper.m
//  RZColorfulExample
//
//  Created by xk_mac_mini on 2019/9/29.
//  Copyright © 2019 rztime. All rights reserved.
//

#import "RZTapActionHelper.h"
@interface RZTapActionHelper ()<UITextViewDelegate>

@end
@implementation RZTapActionHelper

- (void)setTagert:(id)tagert {
    _tagert = tagert;
    
    self.textView.delegate = self;
}

- (NSMutableArray *)tapActions {
    if (!_tapActions) {
        _tapActions = [NSMutableArray new];
    }
    return _tapActions;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    if (_tagert && [_tagert respondsToSelector:@selector(textViewShouldBeginEditing:)]) {
        return [_tagert textViewShouldBeginEditing:textView];
    }
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    if (_tagert && [_tagert respondsToSelector:@selector(textViewShouldEndEditing:)]) {
        return [_tagert textViewShouldEndEditing:textView];
    }
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    if (_tagert && [_tagert respondsToSelector:@selector(textViewDidBeginEditing:)]) {
        [_tagert textViewDidBeginEditing:textView];
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView {
    if (_tagert && [_tagert respondsToSelector:@selector(textViewDidEndEditing:)]) {
        [_tagert textViewDidEndEditing:textView];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if (_tagert && [_tagert respondsToSelector:@selector(textView:shouldChangeTextInRange:replacementText:)]) {
        return [_tagert textView:textView shouldChangeTextInRange:range replacementText:text];
    }
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView {
    if (_tagert && [_tagert respondsToSelector:@selector(textViewDidChange:)]) {
        [_tagert textViewDidChange:textView];
    }
}

- (void)textViewDidChangeSelection:(UITextView *)textView {
    if (_tagert && [_tagert respondsToSelector:@selector(textViewDidChangeSelection:)]) {
        [_tagert textViewDidChangeSelection:textView];
    }
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction NS_AVAILABLE_IOS(10_0) {
    [self didTapActionWithId:URL];
    if (_tagert && [_tagert respondsToSelector:@selector(textView:shouldInteractWithURL:inRange:interaction:)]) {
        return [_tagert textView:textView shouldInteractWithURL:URL inRange:characterRange interaction:interaction];
    }
    if (_tagert && [_tagert respondsToSelector:@selector(textView:shouldInteractWithURL:inRange:)]) {
        return [_tagert textView:textView shouldInteractWithURL:URL inRange:characterRange];
    }
    return YES;
}
- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction NS_AVAILABLE_IOS(10_0) {
    if (_tagert && [_tagert respondsToSelector:@selector(textView:shouldInteractWithTextAttachment:inRange:interaction:)]) {
        return [_tagert textView:textView shouldInteractWithTextAttachment:textAttachment inRange:characterRange interaction:interaction];
    }
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange NS_DEPRECATED_IOS(7_0, 10_0, "Use textView:shouldInteractWithURL:inRange:forInteractionType: instead") {
    [self didTapActionWithId:URL];
    if (_tagert && [_tagert respondsToSelector:@selector(textView:shouldInteractWithURL:inRange:interaction:)]) {
        return [_tagert textView:textView shouldInteractWithURL:URL inRange:characterRange interaction:UITextItemInteractionInvokeDefaultAction];
    }
    if (_tagert && [_tagert respondsToSelector:@selector(textView:shouldInteractWithURL:inRange:)]) {
        return [_tagert textView:textView shouldInteractWithURL:URL inRange:characterRange];
    }
    return YES;
}
- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange NS_DEPRECATED_IOS(7_0, 10_0, "Use textView:shouldInteractWithTextAttachment:inRange:forInteractionType: instead") {
    if (_tagert && [_tagert respondsToSelector:@selector(textView:shouldInteractWithTextAttachment:inRange:)]) {
        return [_tagert textView:textView shouldInteractWithTextAttachment:textAttachment inRange:characterRange];
    }
    return YES;
}

- (void)didTapActionWithId:(NSURL *)tapActioId {
    NSString *tapId;
    if ([tapActioId isKindOfClass:[NSString class]]) {
        tapId = (NSString *)tapActioId;
    } else if ([tapActioId isKindOfClass:[NSURL class]]) {
        tapId = tapActioId.absoluteString;
    }
    [self.tapActions enumerateObjectsUsingBlock:^(NSDictionary *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj[@"RZTapActionId"] isEqualToString:tapId]) {
            void (^action) (id tapId) = obj[@"RZTapActionFunc"];
            if (action) {
                action(tapId);
            }
        }
    }];
}

- (void)dealloc {
    [self.tapActions removeAllObjects];
}

@end
