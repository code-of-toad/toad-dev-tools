from manim import *
"""
Uncomment the next 4 lines for vertical resolution.
"""
# config.pixel_width  = 1080
# config.pixel_height = 1920
# config.frame_width  = 9.0
# config.frame_height = 16.0


class ToadScene(Scene):
    def play(self, *args, **kwargs):
        """
        CUSTOM OVERRIDE
        """
        kwargs = self._apply_defaults(**kwargs)
        super().play(*args, **kwargs)

    def _apply_defaults(self, **kwargs):
        """
        Applies default values for animation parameters if they are not explicitly provided.
        
        `self.play()` Parameter Defaults:
        ---------------------------------
        run_time:  1.0     ->  [0.0, inf)
        lag_ratio: 0.0     ->  [0.0, 1.0]
        rate_func: smooth  ->  {smooth, linear, rush_into, rush_from, there_and_back_with_pause}
        """
        defaults = { 
            'run_time':  1.0,
            'lag_ratio': 0.0,
            'rate_func': smooth,
        }
        for parameter, new_default in defaults.items():
            kwargs.setdefault(parameter, new_default)
        return kwargs


class ToadTemplate(ToadScene):
    def construct(self):
        # ------------------------------ CONFIG -------------------------------
        self._config(grid=True, screen_border=False)
        # ---------------------------------------------------------------------
        pass

    def _config(self, bg_color='#131313', grid=True, screen_border=False):
        self.camera.background_color = bg_color
        if grid:
            self.add(NumberPlane(
                x_range=[-config.frame_width/2,  config.frame_width/2,  1],
                y_range=[-config.frame_height/2, config.frame_height/2, 1],
                background_line_style={
                    "stroke_color": WHITE, "stroke_width": 1, "stroke_opacity": 0.1
                },
                axis_config={
                    "stroke_color": WHITE, "stroke_width": 1, "stroke_opacity": 0.1
                }
            ))
        if screen_border:
            self.add(Rectangle(
                width =config.frame_width,
                height=config.frame_height,
                stroke_color=GREEN,
                stroke_width=20
            ))

