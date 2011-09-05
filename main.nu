; Aligns the current line, calculating the line's position and the
; view's dimensions and passing these to scroll-top-calculator, which
; should be a function or block that calculates a scroll top that is
; then used to scroll the view.
;
; scroll-top-calculator is passed two parameters:
;  - (line-top line-height)
;  - (view-x view-y view-width view-height) (the visibleRect of the text view)
(function align-current-line-with (scroll-top-calculator)
  (do ()
    (let ((text-view (current-text))
          (null-range '(NSNotFound 0)))
      (let ((current-line (text-view currentLine))
            (layout-manager (text-view layoutManager))
            (text-container (text-view textContainer))
            (text-storage (text-view textStorage)))
        (set character-index (text-storage locationForStartOfLine:(text-view currentLine)))
        (set character-rect
          (let (line-rect (layout-manager lineFragmentRectForGlyphAtIndex:(layout-manager glyphIndexForCharacterAtIndex:character-index) effectiveRange:nil))
            line-rect))
        (set desired-scroll-top
          (scroll-top-calculator
            (list (head (tail character-rect)) (head (tail (tail (tail character-rect)))))
            (text-view visibleRect)))
        (let ((clip-view ((text-view enclosingScrollView) contentView))
              (scroll-top desired-scroll-top))
          (clip-view scrollToPoint:(clip-view constrainScrollPoint:`(0 ,scroll-top))))))))

(let ((centering-scroll-top-calculator
        (do (line-top-and-height view-rect)
          (let ((line-top (head line-top-and-height))
                (line-height (head (tail line-top-and-height)))
                (view-height (head (tail (tail (tail view-rect))))))
            (+ (- line-top (/ view-height 2)) (/ line-height 2)))))
      (top-aligning-scroll-top-calculator
        (do (line-top-and-height view-rect)
          (head line-top-and-height)))
      (bottom-aligning-scroll-top-calculator
        (do (line-top-and-height view-rect)
          (let ((line-top (head line-top-and-height))
                (line-height (head (tail line-top-and-height)))
                (view-height (head (tail (tail (tail view-rect))))))
            (+ (- line-top view-height) line-height)))))

  ((ViMap normalMap) unmap:"zz")
  ((ViMap normalMap) map:"zz" toExpression:(align-current-line-with centering-scroll-top-calculator))
  ((ViMap normalMap) unmap:"zt")
  ((ViMap normalMap) map:"zt" toExpression:(align-current-line-with top-aligning-scroll-top-calculator))
  ((ViMap normalMap) unmap:"zb")
  ((ViMap normalMap) map:"zb" toExpression:(align-current-line-with bottom-aligning-scroll-top-calculator)))
