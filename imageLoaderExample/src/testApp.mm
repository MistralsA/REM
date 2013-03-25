#include "testApp.h"

//--------------------------------------------------------------
void testApp::setup(){	
	ofxiPhoneSetOrientation(OFXIPHONE_ORIENTATION_LANDSCAPE_RIGHT);
	
    bunny.loadImage("images/bunnyIcon.png");
    cat.loadImage("images/cat.png");
    bg.loadImage("images/bg.png");
    button.loadImage("images/button.png");
    buttonglow.loadImage("images/buttonglow.png");
    room.loadImage("images/room.jpg");
    vagRounded.loadFont("vag.ttf", 18);
    ofBackground(255, 255, 255);
    stageNum = 1;
    //stageNext = ofRandom(1, 5.99);
    stageNext = 1;
    roomstate = 0;
    timeForShift = rand() % 40 * stageNum;
    elapsed = 0;
    bunnyPos[0] = ofRandom(0, 824); //bunny x
    bunnyPos[1] = ofRandom(0, 568); //bunny y
    bunnyPos[2] = ofRandom(-stageNum-.99, stageNum+.99);  //bunny room location
    catPos[0] = ofRandom(0,824); //cat x
    catPos[1] = ofRandom(0,568); //cat y
    catPos[2] = ofRandom(-stageNum-.99, stageNum+.99); //cat room location
}

//-------------------------------------------------------------
void testApp::update(){
    if(elapsed >= 2000) {
        timeForShift -= 0.05;
    }
    elapsed = ofGetElapsedTimeMillis();
    
	//timeForShift -= 1;
}

//--------------------------------------------------------------
void testApp::draw(){	

    ofSetHexColor(0xFFFFFF);
    ofEnableAlphaBlending();
    
    if (elapsed % 2000 <= 20)   //time before bunnu jumps (in milli)
    {
        bunnyPos[0] = ofRandom(0, 824);
        bunnyPos[1] = ofRandom(0, 568);
        bunnyPos[2] = ofRandom(-stageNum-.99,stageNum+.99);
    }
    
    if (roomstate == bunnyPos[2]) {
        ofSetColor(255,255,255,255-(elapsed % 2000)/8);    // Bunny transparency
        bunny.draw(bunnyPos[0], bunnyPos[1]);
    }
    
    if (roomstate == catPos[2]) {
        cat.draw(catPos[0], catPos[1]);
    }

    ofSetColor(255,255,255,timeForShift*4);    // Room transparency    
    room.draw(0,0, 1024, 768);
    
	ofDisableAlphaBlending();
	ofSetColor(255,122,220);                   //debugging string XD
	vagRounded.drawString(eventString, 0,150);

    
    ofSetColor(255, 255, 255);
        
    /** if (timeforShift <0)
    {
        GAME OVER!!!
    }**/

    sprintf(eventString, "StageNum %i\nstageNext %i\ntimeForShift %2.0f\nbunnypos[2] %d\nRoomstate %i", stageNum, stageNext, timeForShift, bunnyPos[2], roomstate);
    
}

void testApp::testShift()
{
    //change map!
    stageNum = stageNext;
    //stageNext = ofRandom(1, 5.99);
    stageNext = 1;
    timeForShift = ofRandom(20, 40) * stageNum;
    ofResetElapsedTimeCounter();
    elapsed = 0;
    roomstate = 0;
    room.loadImage("images/room.jpg");
    catPos[2] = ofRandom(-stageNum-.99, stageNum+.99);
    
}

//--------------------------------------------------------------
void testApp::exit(){
    
}

//--------------------------------------------------------------
void testApp::touchDown(ofTouchEventArgs & touch){
    /*touchdx = touch.x;
    if(touchdx-bunnyPos[0]< 100 && touchdx-bunnyPos[0] > 0
       && touch.y-bunnyPos[1] < 100 && touch.y-bunnyPos[1] > 0 ){
        testShift();
    }
    
    if(catPos[0]-touchdx < 100 && catPos[0]-touchdx > 0 
       && catPos[1] - touch.y < 100 && catPos[1] -touch.y > 0 ){
        
    }*/
    touchdx = (int) touch.x;
    int ny = (int) touch.y;
    
    int rectTL[2];
    int rectBR[2];
    
    rectTL[0] = bunnyPos[0];
    rectTL[1] = bunnyPos[1];
    
    rectBR[0] = bunnyPos[0] + 100;
    rectBR[1] = bunnyPos[1] + 100;
    
    if((touchdx>rectTL[0] && touchdx < rectBR[0]) && (ny > rectTL[1] && ny < rectBR[1])){
        testShift();
        ofLog(OF_LOG_NOTICE, "You molested the bunny! YOU MONSTER!");
    }
    
}

//--------------------------------------------------------------
void testApp::touchMoved(ofTouchEventArgs & touch){

}

//--------------------------------------------------------------
void testApp::touchUp(ofTouchEventArgs & touch){
    touchux = touchdx - (int) touch.x;
    if (touchux > 100) { //swipe right
            roomstate++;
        if(roomstate >= stageNum) roomstate = stageNum;
            
    } else if (touchux < 100) {
        roomstate--;
        if(roomstate <= -stageNum) roomstate = -stageNum;
    }
    loadRoom();
               
}

void testApp::loadRoom()
{
    switch (roomstate) {
        case 0:
            room.loadImage("images/room.jpg");
            break;
        case -1:
            room.loadImage("images/roomleft.jpg");
            break;
        case 1:
            room.loadImage("images/roomright.jpg");
            break;

        default:
            break;
    }
    
    
}
//--------------------------------------------------------------
void testApp::touchDoubleTap(ofTouchEventArgs & touch){

}

//--------------------------------------------------------------
void testApp::touchCancelled(ofTouchEventArgs & touch){

}

//--------------------------------------------------------------
void testApp::lostFocus(){
    
}

//--------------------------------------------------------------
void testApp::gotFocus(){
    
}

//--------------------------------------------------------------
void testApp::gotMemoryWarning(){
    
}

//--------------------------------------------------------------
void testApp::deviceOrientationChanged(int newOrientation){
    
}

float testApp::scaleTouch(float pos, float newMax, float oldMax){
    //NewValue = (((OldValue - OldMin) * (NewMax - NewMin)) / (OldMax - OldMin)) + NewMin
    return (((pos - 0) * (newMax- 0)) / (oldMax - 0)) + 0;
}
