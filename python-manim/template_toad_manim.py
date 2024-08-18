from manim import *

"""
Uncomment the next 4 lines for vertical resolution.
"""
# config.pixel_width  = 1080
# config.pixel_height = 1920
# config.frame_width  = 4.5
# config.frame_height = 8.0

class ToadTemplate(Scene):
    def construct(self):
        # ------------------------------ CONFIG -------------------------------
        self._config()
        # ---------------------------------------------------------------------
        pass

    def _config(self, bg_color='#131313', grid=True):
        self.camera.background_color = bg_color
        if grid:
            self.add(NumberPlane(
                background_line_style={
                    "stroke_color": WHITE, "stroke_width": 1, "stroke_opacity": 0.1
                },
                axis_config={
                    "stroke_color": WHITE, "stroke_width": 1, "stroke_opacity": 0.1
                }
            ))

