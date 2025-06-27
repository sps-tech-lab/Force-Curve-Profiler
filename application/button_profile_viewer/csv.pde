class csv_manager {
  float[] rise_data;
  float[] drop_data;
  int maxLength;

  csv_manager(int length) {
    maxLength = length;
    rise_data = new float[maxLength];
    drop_data = new float[maxLength];
    // Arrays are initialized with 0.0 by default
  }

  // Add or update rise value at a specific index
  void add_rise(float rise, int index) {
    if (index >= 0 && index < maxLength) {
      rise_data[index] = rise;
    } else {
      println("Index out of bounds in add_rise()");
    }
  }

  // Add or update drop value at a specific index
  void add_drop(float drop, int index) {
    int reversedIndex  = index;
  
    // If index > maxLength, calculate reversed index
    if (index >= maxLength) {
      reversedIndex  = maxLength - (index - maxLength);
    }
  
    if (reversedIndex  >= 0 && reversedIndex  < maxLength) {
      drop_data[reversedIndex ] = drop;
    } else {
      println("Index out of bounds in add_drop(): " + reversedIndex);
    }
  }

  float getrise(int index) {
    if (index >= 0 && index < maxLength) {
      return rise_data[index];
    } else {
      println("Index out of bounds in getrise()");
      return -1;
    }
  }

  float getdrop(int index) {
    if (index >= 0 && index < maxLength) {
      return drop_data[index];
    } else {
      println("Index out of bounds in getdrop()");
      return -1;
    }
  }

  int size() {
    return maxLength;
  }

  void clear() {
    for (int i = 0; i < maxLength; i++) {
      rise_data[i] = 0.0;
      drop_data[i] = 0.0;
    }
  }

  // Save data to CSV [rise<TAB>drop<CR>]
  void save_scan_csv() {
    String timestamp = nf(year(), 4) + nf(month(), 2) + nf(day(), 2) + "_" + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
    String folder = "scans";
    String filename = "scan_" + timestamp + ".csv";
  
    // Get full path to folder inside /data
    String fullFolderPath = dataPath(folder);
    String fullFilePath = fullFolderPath + "/" + filename;
  
    // Ensure directory exists
    File dir = new File(fullFolderPath);
    if (!dir.exists()) {
      dir.mkdirs();
    }
  
    String[] lines = new String[maxLength];
    for (int i = 0; i < maxLength-2; i++) {
      lines[i] = rise_data[i] + "\t" + drop_data[i];
    }
  
    saveStrings(fullFilePath, lines);
    println("Saved to file: " + fullFilePath);
  }
  
    // Save data to CSV [rise<TAB>drop<CR>]
  void update_reference() {
    String ref_name = "data/ref_scan.csv";
        
    String[] lines = new String[maxLength];
    
    for (int i = 0; i < maxLength-2; i++) {
      lines[i] = rise_data[i] + "\t" + drop_data[i];
    }
    saveStrings(ref_name, lines); //Update reference scene chart
    println("Reference Updated");
  }
  
  //Load data from a CSV file
  void load_reference() {
    String filename = "ref_scan.csv";
    
    String[] lines = loadStrings(filename);
    if (lines == null) {
      println("File not found: " + filename);
      return;
    }
  
    int len = min(lines.length, maxLength);
  
    for (int i = 0; i < len; i++) {
      String[] parts = split(lines[i], '\t');
      if (parts.length >= 2) {
        rise_data[i] = float(parts[0]);
        drop_data[i] = float(parts[1]);
        
        //Restore
        ref_prs.data[i]=rise_data[i];
        ref_rel.data[i]=drop_data[i];
        
      } else {
        println("Invalid line at " + i + ": " + lines[i]);
      }
    }
  
    println("Loaded " + len + " entries from " + filename);
  }
}
