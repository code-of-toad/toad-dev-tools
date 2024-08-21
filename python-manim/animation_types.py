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
        kwargs = self._apply_defaults(**kwargs)
        super().play(*args, **kwargs)
    def _apply_defaults(self, **kwargs):
        defaults = {
            'run_time': 1,
            # 'run_time': 0.75,
            # 'rate_func': linear,
        }
        for key, val in defaults.items():
            kwargs.setdefault(key, val)
        return kwargs


class AnimationTypes(ToadScene):
    def construct(self):
        # ------------------------------ CONFIG -------------------------------
        self._config(grid=True, screen_border=False)
        self.add(Square(stroke_opacity=0.1, stroke_width=3, side_length=4))
        # ---------------------------------------------------------------------
        txt = Text('This is some test string!!!').shift(DOWN*3)
        s = Square(color=GREEN, stroke_opacity=1, stroke_width=4, fill_opacity=0.3, side_length=4)
        c = Circle(stroke_opacity=1, stroke_width=20).shift(LEFT*2)
        t = Triangle()
        grp = VGroup(s, c)
        dot = Dot(stroke_width=15)
        arrow = Arrow()

        self.add(txt)
        self.add(s)
        self.add(c)
        # self.add(dot)
        # self.add(arrow)
        self.wait(0.25)
        """
        Animation: TEXTS
        """
        # self.play(Write(txt))
        # self.play(Unwrite(txt))
        # self.play(AddTextLetterByLetter(txt))
        # self.play(RemoveTextLetterByLetter(txt))
        """
        Animation: CREATION
        """
        # self.play(Create(s))
        # self.play(Uncreate(s))
        # self.play(FadeIn(s))
        # self.play(FadeOut(s))
        # self.play(DrawBorderThenFill(s))
        # self.play(GrowFromCenter(s))
        # self.play(GrowFromEdge(s, UP))
        # self.play(GrowFromEdge(s, RIGHT))
        # self.play(GrowFromEdge(s, DOWN))
        # self.play(GrowFromEdge(s, LEFT))
        # self.play(GrowFromPoint(s, [3, 1, 9]))
        # self.play(SpinInFromNothing(s, PI))
        """
        Animation: ATTENTION GRABBER
        """
        # self.play(ApplyWave(arrow))
        # self.play(Wiggle(s))
        # self.play(Circumscribe(s, stroke_width=15, buff=0.3, color=RED))
        # self.play(Circumscribe(txt))
        # self.play(Flash(s, flash_radius=2.5, line_length=0.5, line_stroke_width=8))
        # self.play(Indicate(s))
        # self.play(FocusOn(s))
        # self.play(Broadcast(s))
        # self.play(ShowPassingFlash(s))                          # ???
        # self.play(ShowPassingFlashWithThinningStrokeWidth(s))   # ???
        """
        Animation: TRANSFORMATION
        """
        # self.play(FadeToColor(s, PURPLE))
        # self.play(Transform(s, c))
        # self.play(FadeTransform(s, c)
        # self.play(ClockwiseTransform(s, c))
        # self.play(CounterclockwiseTransform(s, c))
        # self.play(ReplacementTransform(s, c))
        # self.play(Rotate(s))
        # self.play(Rotate(s, angle=TAU, about_point=ORIGIN), run_time=4, rate_func=linear)
        # self.play(Rotating(s))
        # self.play(ScaleInPlace(s, scale_factor=2))
        # self.play(ShrinkToCenter(c))
        """
        Animation: Etc.
        """
        # self.play(TracedPath(s))
        # self.play(GrowArrow(arrow))
        # self.play(MoveAlongPath(dot, s)); self.play(FadeOut(dot))
        # self.play(ChangeSpeed())              # ???
        # self.play(CyclicReplace())            # ???
        # self.play(Restore())                  # ???
        # self.play(TransformMatchingShapes())  # ???
        # self.play(TransformMatchingTex())     # ???
        """
        Animation: DEBUG
        """
        # self.add(grp)
        # self.wait(0.5)
        # self.play(ShowIncreasingSubsets(grp))
        # self.play(ShowSubmobjectsOneByOne(grp))
        """
        Mobject.animate.________()
        """
        # self.play(s.animate.shift(RIGHT))
        # self.play(s.animate.set_fill(color=BLUE, opacity=0.75))
        # self.play(s.animate.rotate(PI/3))  # This rotation method scales the object down mid-rotation for effect.
        # self.play(s.animate.scale(2))
        # self.play(t.animate.flip())
        # self.play(t.animate.flip(RIGHT))
        # self.play(s.animate.stretch(factor=2, dim=0))  # dim = 0 (x-axis), 1 (y-axis), 2 (z-axis)
        # self.play(s.animate.pose_at_angle())
        # self.play(s.animate.center())
        # self.play(s.animate.align_on_border(UP))
        # self.play(s.animate.align_on_border(DL, buff=0))  # `animate.to_edge()` , `animate.align_on_border()`, and `animate.to_corner()` all do the same thing.
        # self.play(s.animate.to_corner(UP))
        # self.play(s.animate.to_corner(DL, buff=0))
        # self.play(s.animate.to_edge(UP))
        # self.play(s.animate.to_edge(DL, buff=0))
        # self.play(s.animate.next_to(c, DOWN, buff=1))
        # self.play(s.animate.scale_to_fit_width(3))
        # self.play(s.animate.stretch_to_fit_width(5))
        # self.play(s.animate.stretch_to_fit_height(2))
        # self.play(s.animate.scale_to_fit_height(6))
        # self.play(s.animate.set_coord(value=3, dim=1))  # dim = 0 (x-axis), 1 (y-axis), 2 (z-axis)
        # self.play(s.animate.set_x(3))
        # self.play(s.animate.set_y(1))
        # self.play(grp.animate.space_out_submobjects())
        # self.play(s.animate.replace(c))
        # self.play(s.animate.surround(c))
        # self.play(c.animate.replace(s))
        # self.play(c.animate.surround(s))
        # self.play(s.animate.add_background_rectangle(color=PURPLE))
        # self.play(s.animate.set_color(color=BLUE))
        # self.play(s.animate.set_color_by_gradient([BLUE, WHITE]))
        # self.play(s.animate.fade())
        # self.play(s.animate.fade_to(color=WHITE, alpha=0.5))
        # self.play(s.animate.match_color(c))
        # self.play(s.animate.match_dim_size(c, dim=0))  # dim = 0 (x-axis), 1 (y-axis), 2 (z-axis)
        # self.play(s.animate.match_width(c))
        # self.play(s.animate.match_height(c))
        # self.play(s.animate.match_x(c))
        # self.play(s.animate.match_y(c))
        # self.play(grp.animate.arrange())
        # self.play(grp.animate.arrange_in_grid())
        # self.play(s.animate.become(c))
        # self.play(s.animate.match_points(c))

        self.wait(2)

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

