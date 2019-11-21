//
//  RZTapActionHelper.m
//  RZColorfulExample
//
//  Created by xk_mac_mini on 2019/9/29.
//  Copyright © 2019 rztime. All rights reserved.
//

#import "RZTapActionHelper.h"
#import "UITextView+RZColorful.h"

@interface RZTapActionHelper ()<UITextViewDelegate>

@property (nonatomic, weak) id tagert;

@end
@implementation RZTapActionHelper

- (void)setTextView:(UITextView *)textView {
    _textView = textView;
    _tagert = textView.delegate;
    _textView.delegate = self;
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
    BOOL result = [self didTapActionWithId:URL];
    BOOL result2 = YES;
    if (_tagert && [_tagert respondsToSelector:@selector(textView:shouldInteractWithURL:inRange:interaction:)]) {
        result2 = [_tagert textView:textView shouldInteractWithURL:URL inRange:characterRange interaction:interaction];
    }
    if (_tagert && [_tagert respondsToSelector:@selector(textView:shouldInteractWithURL:inRange:)]) {
        result2 = [_tagert textView:textView shouldInteractWithURL:URL inRange:characterRange];
    }
    return result && result2;
}
- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction NS_AVAILABLE_IOS(10_0) {
    if (_tagert && [_tagert respondsToSelector:@selector(textView:shouldInteractWithTextAttachment:inRange:interaction:)]) {
        return [_tagert textView:textView shouldInteractWithTextAttachment:textAttachment inRange:characterRange interaction:interaction];
    }
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange NS_DEPRECATED_IOS(7_0, 10_0, "Use textView:shouldInteractWithURL:inRange:forInteractionType: instead") {
    BOOL result = [self didTapActionWithId:URL];
    BOOL result2 = YES;
    if (_tagert && [_tagert respondsToSelector:@selector(textView:shouldInteractWithURL:inRange:interaction:)]) {
        result2 = [_tagert textView:textView shouldInteractWithURL:URL inRange:characterRange interaction:UITextItemInteractionInvokeDefaultAction];
    }
    if (_tagert && [_tagert respondsToSelector:@selector(textView:shouldInteractWithURL:inRange:)]) {
        result2 = [_tagert textView:textView shouldInteractWithURL:URL inRange:characterRange];
    }
    return result && result2;
}
- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange NS_DEPRECATED_IOS(7_0, 10_0, "Use textView:shouldInteractWithTextAttachment:inRange:forInteractionType: instead") {
    if (_tagert && [_tagert respondsToSelector:@selector(textView:shouldInteractWithTextAttachment:inRange:)]) {
        return [_tagert textView:textView shouldInteractWithTextAttachment:textAttachment inRange:characterRange];
    }
    return YES;
}

- (BOOL)didTapActionWithId:(NSURL *)tapActioId {
    if (self.textView.rzDidTapTextView) {
        return self.textView.rzDidTapTextView(tapActioId);
    }
    return YES;
}

- (void)dealloc {
    _textView.delegate = _tagert;
}

@end
