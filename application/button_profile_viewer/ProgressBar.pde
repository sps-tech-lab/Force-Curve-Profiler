class ProgressBar {
  float x, y;                // Position of the progress bar
  float width, height;       // Dimensions of the progress bar
  float progress;            // Current progress value (0 to 100)
  color bgColor, fgColor;    // Background and foreground colors
  Boolean autofit;           //Autofit to window width
  PApplet parent;            // Reference to the main PApplet
  

  // Constructor
  ProgressBar(PApplet p, float x, float y, float width, float height, color bgColor, color fgColor, Boolean autofit) {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    this.bgColor = bgColor;
    this.fgColor = fgColor;
    this.progress = 0;
    this.autofit = autofit;
    this.parent = p;
  }

  // Update progress value
  void setProgress(float value) {
    progress = constrain(value, 0, 100);
  }

  // Display the progress bar
  void display() {
    // Draw background
    fill(bgColor);
    if( autofit == true ){
      rect(x, y, parent.width, height);
    }else{
      rect(x, y, width, height);
    }

    // Draw foreground based on the progress
    fill(fgColor);
    float progressWidth;
    if( autofit == true ){
      progressWidth = map(progress, 0, 100, 0, parent.width);
    }else{
      progressWidth = map(progress, 0, 100, 0, width);
    }
    rect(x, y, progressWidth, height);
  }
}
