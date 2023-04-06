class SeparationControl{
  float value = 0.0;
  float minValue = 0.0;
  float maxValue = 100.0;
  float scrollBarX = 80;
  float scrollBarY = 50;
  void setValue(float newvalue){
    value = newvalue;
  }
  float getValue(){
    return value;
  }
  float getX(){
    return scrollBarX;
  }
  float getY(){
    return scrollBarY;
  }
  float getMinValue(){
    return minValue;
  }
  float getMaxValue(){
    return maxValue;
  }
}
