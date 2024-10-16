//Serial port class
class Serial_port{ 
    Boolean     serial_connection = false;
    Serial      serial_port = null;             // the serial port
    String      serial_list;                    // list of serial ports
    int         serial_list_index = 0;          // currently selected serial port 
    int         num_serial_ports = 0;           // number of serial ports in the l
    int         serial_speed = 115200;
    Boolean     wait_responde = false;
  Serial_port(){  
  } 
  
  //Update serial ports list
  void update(){
      serial_list = Serial.list()[serial_list_index];
      num_serial_ports = Serial.list().length;
  }
  
  //Incriment serial port index in list
  void inc(){
    if (serial_list_index < (num_serial_ports - 1)) {
      serial_list_index++;
      serial_list = Serial.list()[serial_list_index];      // move one position up in the list of serial ports
    }
  }
  
  //Decriment serial port index in list
  void dec(){
    if (serial_list_index > 0) {      
      serial_list_index--;
      serial_list = Serial.list()[serial_list_index];      // move one position down in the list of serial ports
    }
  }
  
  //Get name of selected serial port
  String get_name(){
    return serial_list;
  }
  
  //Get pointer to selected serial port
  Serial get_port(){
    return serial_port;
  }
  
  //Get connection state
  Boolean get(){
    return serial_connection;
  }
  
  Boolean inWaitState(){
    return wait_responde;
  }

  void writeln(String str){
    if(serial_port != null){
      char[] a = str.toCharArray();
      for( int i = 0; i < str.length(); i++ ){
        serial_port.write(a[i]);
      }
    }
  }
  
  void writearr(int[] arr, int len){
    if(serial_port != null){
      for( int i = 0; i < len; i++ ){
        serial_port.write(arr[i]);
      }
    }
  }
  
  //Set connection state & open/close port
  void set(Boolean toggle){
    if( serial_connection != toggle ){
      serial_connection = toggle;
      
      if( toggle == true ){
        println(serial_list+" Connect");
        if(serial_port == null){
          serial_port = open_port(Serial.list()[serial_list_index], serial_speed);       // connect to the selected serial port
          if(serial_port != null){
            serial_port.bufferUntil('\n');
            serial_port.clear();
          }else{
            serial_connection = false;
          }
        }
      }else{
        if(serial_port != null){
          println(serial_list+" Disconnect");
          serial_port.clear();
          serial_port.stop();
          serial_port = null;
        }
      }
    }
  }
} 

/**
  **************************************************************************************************
  * @brief      Serial event parser 
  * @details    Common for both serial channels
  **************************************************************************************************
**/
void serialEvent(Serial port){ 
  // Read the entire incoming line
  String buffer = port.readStringUntil('\n');
  
  // Check if buffer is not empty and process the line
  if (buffer != null) {
    parseData(buffer);
  }
} 

// Parse the incoming data string
void parseData(String data) {
  // Remove any extra newline or carriage return characters
  data = trim(data);

  // Split the string by tabs ('\t')
  String[] parts = split(data, '\t');
  
  // Ensure that the parts array has the expected 3 elements
  if (parts.length == 3) {
    // Parse the data: parts[0] = integer, parts[1] = float, parts[2] = String
    int index = int(parts[0]);
    float value = float(parts[1]);
    String status = parts[2];
    
    // Print the parsed values to the console for debugging
    println("Index: " + index + " | Value: " + value + " | Status: " + status);
    appendTextToFile(outFilename, index + "\u0009" + value + "\u0009" + status);
    
    // Store parsed values...
    if(status.equals("PRESS")){
      press.data[index]=value;
    }
    if(status.equals("RELEASE")){
      relis.data[index]=value;
    }


  } else {
    println("Error: Incorrect data format:");
    println("[ "+data+" ]");
  }
}
