class Chrat {
  float   x, y;              // Position of the progress bar
  float   width, height;     // Dimensions of the progress bar
  Boolean autofit = true;    // Autoscale chart
  color   line_color;        // Line color
  int     stroke;            // Line weight
  int     pos;               // Current position in chart
  
  float[] data = new float[502]; //Data
  

  // Constructor
  Chrat(float x, float y, float width, float height, color line_color, int stroke, Boolean autofit) {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    this.line_color = line_color;
    this.autofit = autofit;
    this.stroke = stroke;
    
    // Initialize the data array with random values for testing
    for (int i = 0; i < data.length; i++) {
      data[i] = -1; //int(random(0, 1000));  // Values in the range 0 to 1000
    }
  }

  // Display the progress bar
  void display() {
    // Draw background
    //fill(0);
    //noStroke();
    //rect(x, y, this.width, this.height);
    
    stroke(line_color);
    strokeWeight(this.stroke);
    
    // Find min and max values in the data array
    float minValue = 0;   //min(data);
    float maxValue = 200; //max(data);

    // Calculate the width of each data point in the chart
    float stepX = this.width / (float) data.length;
  
    // Draw the data points or lines
    for (int i = 1; i < data.length - 1; i++) {
      if( data[i] != -1 ){
        float mappedY1,mappedY2;
        
        if( data[i+1] == -1 ){
          // Map data values to the height of the chart (Y-axis)
          mappedY1 = map(data[i - 1], minValue, maxValue, y + this.height, y);  // First point
          mappedY2 = map(data[i], minValue, maxValue, y + this.height, y);  // Next point
        }else{
          // Map data values to the height of the chart (Y-axis)
          mappedY1 = map(data[i], minValue, maxValue, y + this.height, y);  // First point
          mappedY2 = map(data[i+1], minValue, maxValue, y + this.height, y);  // Next point
        }
        
        // Draw line between the two points
        line(x + i * stepX, mappedY1, x + (i + 1) * stepX, mappedY2);
      }
    }
    fill(line_color);
    noStroke();
    float mappedY = map(data[pos], minValue, maxValue, y + this.height, y);  // First point
    triangle(x+pos*stepX-5, mappedY+10, x+pos*stepX, mappedY, x+pos*stepX+5, mappedY+10);
  }
  
  void upload_data(String file, String way){
    String[] lines = loadStrings(file);
    println("REF SCAN UPLOADED. There are " + lines.length + " lines");
    
    for (int i = 0 ; i < lines.length; i++) {
      // Remove any extra newline or carriage return characters
      lines[i] = trim(lines[i]);
    
      // Split the string by tabs ('\t')
      String[] parts = split(lines[i], '\t');
      
      // Ensure that the parts array has the expected 3 elements
      if (parts.length == 3) {
        // Parse the data: parts[0] = integer, parts[1] = float, parts[2] = String
        int index = int(parts[0]);
        float value = float(parts[1]);
            String status = parts[2];

        //Store data
        if(way.equals("PRESS")){
          // Store parsed values...
          if(status.equals("PRESS")){
            data[index]=value;
          }
        }
        if(way.equals("RELEASE")){
          // Store parsed values...
          if(status.equals("RELEASE")){
            data[index]=value;
          }
        }
        
      } else {
        println("Error: Incorrect data format:");
        println("[ "+data+" ]");
      }
    }
  }
}
