; ©2011 Arun S K.
; http://www.skipser.com

; Add a text watermark in a corner or image.

(define (script-fu-textwatermark image drawable text font pixsize location opacity offsetx offsety)

  (let*

;   Save the foreground color

    ((old-fg (car (gimp-context-get-foreground))))

;   Set the foreground color to white

     (gimp-context-set-foreground '(255 255 255))

  (let*

;   Set the X and Y locations offset by 10 pixels from the chosen corner

     ((imagewid (car (gimp-image-width image)))
      (imagehgt (car (gimp-image-height image)))

      (ytext
         (cond ((<= location 1) (- (- imagehgt pixsize) offsety))
               ((>= location 2) 0)))

      (textwid (car (gimp-text-get-extents-fontname text pixsize 0 font)))

      (xtext
         (cond ((= (fmod location 2) 0) 10)
               ((= (fmod location 2) 1) (- (- imagewid textwid) offsetx))))

;   Create a layer with the watermark text

      (tlayer (car (gimp-text-fontname image -1 xtext ytext text -1 TRUE
          pixsize 0 font))))

;   Bump map the watermark layer

      (plug-in-bump-map 1 image tlayer tlayer 135 45 3 0 0 0 0 1 0 0)

;   Set the opacity of the watermark layer

      (gimp-layer-set-opacity tlayer opacity)

;   Combine the original image layer and the watermark layer

      (gimp-image-flatten image)
    )

;   Restore the old foreground color

    (gimp-context-set-foreground old-fg)
  )

;   Update the display

  (gimp-displays-flush)
)

(script-fu-register "script-fu-textwatermark"
                    "<Image>/Script-Fu/MyScripts/TextWatermark"
                    "TextWatermark"
                    "Arun S K"
                    "copyright"
                    "2011/10/14"
                    "RGB*, GRAY*"
                    SF-IMAGE "Input Image" 0
                    SF-DRAWABLE "Input Drawable" 0
                    SF-STRING "Watermark text" "© Roan Fourie"
                    SF-FONT "Font" "Comic Sans MS"
                    SF-ADJUSTMENT "Size (pixels)" '(25 0 1000 5 10 0 1)
                    SF-OPTION "Location" '("Lower left" "Lower right" "Upper left" "Upper right")
                    SF-ADJUSTMENT "Opacity" '(40 0 100 5 10 0 1)
                    SF-VALUE "OffsetX" "20"
                    SF-VALUE "OffsetY" "20"
                    )
