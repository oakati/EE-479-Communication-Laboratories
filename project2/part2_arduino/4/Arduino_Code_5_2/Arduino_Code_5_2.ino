int sensorValue = 0; 

void setup () 
{
  Serial.begin(115200); // serial communication hizini belirleme 
  
} 

void loop ()
{
  sensorValue = analogRead(A1); //A0 portundan sample alma 
  sensorValue = sensorValue / 4; //10 bitlik sample’i precision kaybi yaparak 8bit’e cevirmis oluyoruz
  Serial.write(sensorValue); // serial port’tan PC’ye yollama
  
}  
