class Settings{
  float scrollBarWidth = 20;
  float scrollBarHeight = 100;
void draw_cohision_control(CohisionControl coh) {
  background(173,216,230);
  fill(200);
  rect(coh.getX(), coh.getX(), scrollBarWidth, scrollBarHeight);
  float knobY = map(value, coh.getMaxValue(), coh.getMinValue(), coh.getX(), coh.getX() + scrollBarHeight);
  fill(220,220,235);
  ellipse(coh.getX() + scrollBarWidth/2, knobY, 20, 20);
}
void draw_separation_control(SeparationControl sep ) {
}
void draw_align_control(AlignControl align) {
  background(173,216,230);
  fill(200);
  rect(align.getX(), align.getY(), scrollBarWidth, scrollBarHeight);
  float knobY = map(value, align.getMaxValue(), align.getMinValue(), align.getX(), align.getY() + scrollBarHeight);
  fill(220,220,235);
  ellipse( align.getY() + scrollBarWidth/2, knobY, 20, 20);
}
}
