; ©2011 Arun S K.
; http://www.skipser.com

; Add an external watermark image in a corner or image.

(define (script-fu-imagewatermark image layer photo location opacity offsetx offsety)

;Open file
(set! layer ( car (gimp-file-load-layer 0 image photo)))

(let*
  ((imagewid (car (gimp-image-width image)))
    (imagehgt (car (gimp-image-height image)))

    (lwid  (car (gimp-drawable-width  layer)))
      (lhgt (car (gimp-drawable-height layer)))

;   Set the X and Y locations offset by 10 pixels from the chosen corner
    (xlayer
         (cond ((= (fmod location 2) 0) offsetx)
               ((= (fmod location 2) 1) (- (- imagewid lwid) offsetx))))

    (ylayer
         (cond ((<= location 1) (- (- imagehgt lhgt) offsety))
               ((>= location 2) 0)))

  )

; Set the offset

  (gimp-layer-set-offsets layer xlayer ylayer)

;    Add layer

  (gimp-image-add-layer image layer 0)

; Set the opacity of the watermark layer

  (gimp-layer-set-opacity layer opacity)

)

;Add layer

(gimp-displays-flush)

)

(script-fu-register "script-fu-imagewatermark"
"<Image>/Script-Fu/MyScripts/ImageWatermark"
"ImageWatermark"
"Arun S K"
"copyright"
"2011/10/14"
"RGB*, GRAY*"
SF-IMAGE "Image" 0
SF-DRAWABLE "Drawable" 0
SF-FILENAME "Watermark Photo" "Your Image"
SF-OPTION "Location" '("Lower left" "Lower right" "Upper left" "Upper right")
SF-ADJUSTMENT "Opacity" '(35 0 100 5 10 0 1)
SF-VALUE "OffsetX" "10"
SF-VALUE "OffsetY" "10"
)

