from manim import *


class ToadTemplate(Scene):

    def construct(self):
        # -------- HELPERS --------
        self._display_unit_grid()
        self._display_crosshair(RED)
        self._set_bg_color()
        # -------------------------
        pass


    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
                               Helper Methods: START                           
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    def _display_crosshair(self, color=WHITE):
        line_horizontal = Line(start=LEFT*8,   end=RIGHT*8, stroke_width=0.3, color=color)
        line_vertical   = Line(start=DOWN*4.5, end=UP*4.5,  stroke_width=0.3, color=color)
        self.add(line_horizontal, line_vertical)

    def _display_unit_grid(self, x_range=(-8.0, 8.0, 1.0), y_range=(-4.5, 4.5, 1.0), color=WHITE):
        # Create vertical lines
        for x in np.arange(x_range[0], x_range[1] + x_range[2], x_range[2]):
            line = Line(start=DOWN * y_range[1], end=UP * y_range[1],
                        stroke_width=0.3, color=color)
            line.move_to(RIGHT * x)
            self.add(line)
        # Create horizontal lines
        for y in np.arange(y_range[0], y_range[1] + y_range[2], y_range[2]):
            line = Line(start=LEFT * x_range[1], end=RIGHT * x_range[1],
                        stroke_width=0.3, color=color)
            line.move_to(UP * (y + 0.5))
            self.add(line)

    def _set_bg_color(self, color='#131313'):
        self.camera.background_color = color
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
                                Helper Methods: END                            
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

