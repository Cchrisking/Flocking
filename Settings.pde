class Settings{
  float value = 0.0;
  float minValue = 0.0;
  float maxValue = 100.0;
  float scrollBarWidth = 20;
  float scrollBarHeight = 200;
  float scrollBarX = 50;
  float scrollBarY = 50;
  void separation(){
 background(255);
  fill(200);
  rect(scrollBarX, scrollBarY, scrollBarWidth, scrollBarHeight);
  float knobY = map(value, minValue, maxValue, scrollBarY, scrollBarY + scrollBarHeight);
  fill(0);
  ellipse(scrollBarX + scrollBarWidth/2, knobY, 20, 20);
  }
}
