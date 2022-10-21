  int a = 13;
    float freq_offset = 0;
//  int random(95,105) = 1e2*(1+freq_offset/100);
  char str[8] = "1111111";
  //char str[7] = "100000";
  int symbolSize = 7;
  char text[] = "HelloworldabcABComeralperenkatiOMERALPERENKATI";
//  char text[] = "qwerty";

  void setup() {
    Serial.begin(9600);
    Serial.setTimeout(10);
    pinMode(a, OUTPUT);
      digitalWrite(a, HIGH);
      delay(symbolSize * random(95,105));
      Serial.println(random(95,105));
  }
  void loop() {
//      while (1){

//      digitalWrite(a, LOW);
//      delay(symbolSize * random(95,105));
//        }
      for (int i = 0; i < sizeof(text) - 1; i++) {
        itoa(int(text[i]), str, 2);
      Serial.println(text[i]);
        for (int j = 0; j < sizeof(str) - 1; j++) {
          if (str[j] == '1') {
            digitalWrite(a, HIGH);
          } else if (str[j] == '0') {
            digitalWrite(a, LOW);
          }
          delay(random(95,105));
          Serial.print(str[j]);
        }
        Serial.println("");
      }
      digitalWrite(a, LOW);
      delay(symbolSize * random(95,105));
      while (1) {}
  }
