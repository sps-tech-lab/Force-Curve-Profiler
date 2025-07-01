/**
  **************************************************************************************************
  * @brief      My watermark
  **************************************************************************************************
**/
void control_watermark(){ 
  //Draw watermark
  textSize(20);
  fill(bgcolor);
  stroke(txcolor);
  textAlign(RIGHT, CENTER);
  rect( 0, height-30, width, 30);
  fill(txcolor);
  text("SPS TECH :: 2024", width-10, height-16);
  line(width-160, height, width-160, height-30);
}

/**
  **************************************************************************************************
  * @brief      Draw a group of serial control buttons
  **************************************************************************************************
**/
void control_group(String name, int x, int y) 
{
  fill(bgcolor);
  stroke(txcolor);
  rect( x-1, y-30, 170+1, 50);
  line(x+395, height, x+395, height-30);
  line(x+460, height, x+460, height-30);
  

  if(Button("", x+30, y-25, 20, 20, 7)){
    btn_click(name,"+");
  }
  if(Button("", x+5, y-25, 20, 20, 7)){
    btn_click(name,"-");
  }
  

  serial.set(Toggle(serial.get(), x+120, y-25, 40, 20 ));
  textSize(20);
  fill(txcolor);
  textAlign(LEFT, CENTER);
  text("FORCE-CURVE PROFILER", x+180, y-16);
  text("v1.2", x+410, y-16);
  
  textSize(20);
  fill(txcolor);
  textAlign(LEFT, CENTER);
  text("+", x+35, y-16);
  text("-", x+12, y-16);

  textAlign(CENTER, CENTER);
  text(serial.get_name(), x+85, y-17);
  
}

/**
  **************************************************************************************************
  * @brief      Button click handler
  **************************************************************************************************
**/
void btn_click(String name, String dir){
  if( dir == "+" ){
    serial.inc();
  }else{
    serial.dec();
  }
}

/**
  **************************************************************************************************
  * @brief      "new Serial()" cаll wrap
  **************************************************************************************************
**/
Serial open_port(String port_name, int port_speed){
  Serial res = null;
  try {
    res = new Serial(this, port_name, port_speed);
  }catch(Exception e){
    println("Error opening serial port " + port_name + ": " + e.getMessage());
  }
  return res;
}
