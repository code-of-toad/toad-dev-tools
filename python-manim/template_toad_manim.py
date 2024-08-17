from manim import *


class ToadTemplate(Scene):

    def construct(self):
        # ------------------------------ CONFIG -------------------------------
        config.default_font = 'Arial'
        self.camera.background_color = '#131313'
        self.add(NumberPlane(
            background_line_style={
                "stroke_color": WHITE, "stroke_width": 1, "stroke_opacity": 0.1
            },
            axis_config={
                "stroke_color": WHITE, "stroke_width": 1, "stroke_opacity": 0.1
            }
        ))
        # ---------------------------------------------------------------------
        pass

