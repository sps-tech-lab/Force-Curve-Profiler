//Includes
import     java.io.BufferedWriter;
import     java.io.FileWriter;
import     processing.serial.*;

//Objects
Serial_port serial = new Serial_port();

//Collected data
Chrat       press, relis, ref_prs, ref_rel;
csv_manager csv;


/**
  **************************************************************************************************
  * @brief      Setup
  **************************************************************************************************
**/
void setup() 
{
  size( 1200, 850 );
  
  serial.update();
  
  press = new Chrat( 10, 10, width-20, height-100, color(#00a2ff), 2, true);
  relis = new Chrat( 10, 10, width-20, height-100, color(#ff9a00), 2, true);
  
  ref_prs = new Chrat( 10, 10, width-20, height-100, color(#00a2ff,50), 1, true);
  ref_rel = new Chrat( 10, 10, width-20, height-100, color(#ff9a00,50), 1, true);
  
  csv = new csv_manager(502);  
  csv.load_reference();
}

/**
  **************************************************************************************************
  * @brief      Main loop
  **************************************************************************************************
**/
void draw() 
{
  background(bgcolor);

  control_watermark();
  control_group(0, height);

  relis.display();
  press.display();
  ref_rel.display();
  ref_prs.display();
}
