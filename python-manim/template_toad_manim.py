from manim import *


class ToadTemplate(Scene):
    def _config(self, bg_color='#131313', grid=True, font='Arial'):
        config.default_font = font
        self.camera.background_color = bg_color
        if grid is True:
            self.add(NumberPlane(
                background_line_style={
                    "stroke_color": WHITE, "stroke_width": 1, "stroke_opacity": 0.1
                },
                axis_config={
                    "stroke_color": WHITE, "stroke_width": 1, "stroke_opacity": 0.1
                }
            ))

    def construct(self):
        # ------------------------------ CONFIG -------------------------------
        self._config()
        # ---------------------------------------------------------------------
        pass
