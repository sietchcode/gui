//////////////////////////////////////////////////////////////////////////////
// Knitty Serial Protocol
import processing.serial.*;

// The serial port:
Serial serialCommunication = null;

// Receive commands
final char COM_CMD_PATTERN = 'P';
final char COM_CMD_PATTERN_BACK = 'B';
final char COM_CMD_PATTERN_END = 'E';
final char COM_CMD_CURSOR = 'C';
final char COM_CMD_IFDR = 'I';
final char COM_CMD_RESPONSE = 'R';
final char COM_CMD_DIRECTION = 'D';
final char COM_CMD_SEPERATOR = ':';
final char COM_CMD_DEBUG = 'V';
final char COM_CMD_SERVO = 'S';
final char COM_CMD_FIRST_NEEDLE = 'F';


final char COM_CMD_PLOAD_END = '\n';

// Parser states
final char COM_PARSE_CMD = 0x01;
final char COM_PARSE_SEP = 0x02;
final char COM_PARSE_PLOAD = 0x03;


char parserState = COM_PARSE_CMD;
char parserReceivedCommand = 0;
String parserReceivedPayload;

int serialCommunicationStarted = 0;

void executeCommand(char cmd, String payload) {


  switch(cmd) {
  case COM_CMD_IFDR:
    // function to call if IFDR is triggerd
    break;

  case COM_CMD_DIRECTION:
    // moveRowInGUI();
    InfoText = ("Direction: " + payload);
    //pintln(payload);
    break;

  case COM_CMD_RESPONSE:
    InfoText =  ("Response: " + payload);
    if (payload.equals("Recieved")) {
    } else {
      print("Response: ");
      println(payload);
    }
    //choose colour with servo
    if (payload.equals("ColourChanger ON")) {
      // changeColour();
    }

    if (payload.equals("ColourChanger OFF")) {
      // disableServos();
    }

    // disable Servo after colour change
    if (payload.equals("Calibrate")) {
      disableServos();
    }

    break;




  case COM_CMD_DEBUG:
    print("Debug: ");
    println(payload);
    break;

  case COM_CMD_PATTERN_END:
    // do not send another row if test button is used
    if (GUIlocked==false) {
      knittigInProgress=false;
    }
    else {
      buttonKnitRow(0);
      // moveRowInGUI();
    }
    println("Pattern end");
    break;
  }
}

void sendCommand(char cmd, String payload) {

  if (serialCommunication == null || serialCommunicationStarted == 0) {
    return;
  }

  serialCommunication.write(cmd);
  serialCommunication.write(COM_CMD_SEPERATOR);
  serialCommunication.write(payload);
  serialCommunication.write("\n");
}


void initSerialCommunication() {
  serialCommunication = new Serial(this, Serial.list()[serialport], 115200);
  serialCommunicationStarted = 1;
}

void parserSerialStream() {

  if (serialCommunication == null || serialCommunication.available() == 0) {
    return;
  }

  char buffer = (char) serialCommunication.read();

  switch(parserState) {

  case COM_PARSE_CMD:
    if (buffer == COM_CMD_DIRECTION || buffer == COM_CMD_IFDR || buffer == COM_CMD_RESPONSE || buffer == COM_CMD_DEBUG || buffer == COM_CMD_PATTERN_END) {
      parserState = COM_PARSE_SEP;
      parserReceivedCommand = buffer;
    }
    break;

  case COM_PARSE_SEP:

    parserReceivedPayload = "";

    // We're awaiting a seperator here, if not, back to cmd
    if (buffer == COM_CMD_SEPERATOR) {
      parserState = COM_PARSE_PLOAD;
      break;
    }

    parserState = COM_PARSE_CMD;
    break;

  case COM_PARSE_PLOAD:

    if (buffer == COM_CMD_PLOAD_END) {
      // Everything is read, execute command
      executeCommand(parserReceivedCommand, parserReceivedPayload);
      parserState = COM_PARSE_CMD;
      break;
    }

    parserReceivedPayload += buffer;
    break;
  }
}
