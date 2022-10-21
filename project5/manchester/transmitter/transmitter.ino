  int a = 13;
    float freq_offset = 0;
  int myDelay = 1e2*(1+freq_offset/100);
  int symbolSize = 14;
//  char text[] = "qwertyuıopguasdfghjklsizxcvbnmocQWERTYUIOPGUASDFGHJKLSIZXCVBNMOC";
    char text[] = "qwertyuıopguasdfghjklsizxcvbnmocQWERTYUIOPGUASDFGHJKLSIZXCVBNMOC";
  char str [8] = "_______";
  void setup() {
    Serial.begin(9600);
    Serial.setTimeout(10);
    pinMode(a, OUTPUT);
      digitalWrite(a, HIGH);
      delay(symbolSize * myDelay);
      Serial.println(symbolSize * myDelay);
      Serial.println(myDelay);
  }
  void loop() {
      for (int i = 0; i < sizeof(text) - 1; i++) {
        itoa(int(text[i]), str, 2);
      Serial.println(text[i]);
        for (int j = 0; j < sizeof(str) - 1; j++) {
          if (str[j] == '1') {
            digitalWrite(a, LOW);
            delay(myDelay);
            digitalWrite(a, HIGH);
            } else if (str[j] == '0') {
            digitalWrite(a, HIGH);
            delay(myDelay);
            digitalWrite(a, LOW);
          }
            delay(myDelay);
          Serial.print(str[j]);
        }
        Serial.println("");
      }
      digitalWrite(a, LOW);
      delay(symbolSize * myDelay);
      while (1) {}
  }
