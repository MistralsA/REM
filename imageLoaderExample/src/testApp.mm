#include "testApp.h"

//--------------------------------------------------------------
void testApp::setup(){	
	ofxiPhoneSetOrientation(OFXIPHONE_ORIENTATION_LANDSCAPE_RIGHT);
	
    bunny.loadImage("images/bunnyIcon.png");
    bg.loadImage("images/bg.png");
    button.loadImage("images/button.png");
    buttonglow.loadImage("images/buttonglow.png");
    room.loadImage("images/room.jpg");
    vagRounded.loadFont("vag.ttf", 18);
    ofBackground(255, 255, 255);
    stageNum = 1;
    stageNext = ofRandom(1, 5.99);
    roomstate = 0;
    timeForShift = rand() % 40 * stageNum;
    elapsed = 0;
    bunnyPos[0] = ofRandom(0, 824); //bunny x
    bunnyPos[1] = ofRandom(0, 568); //bunny y
    bunnyPos[2] = ofRandom(0-stageNum, stageNum);  //bunny room location
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

	ofScale(0.5, 0.5, 0.5);
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

    ofSetColor(255,255,255,timeForShift*4);    // Room transparency    
    room.draw(0,0);
    
	ofDisableAlphaBlending();

	ofSetColor(255,122,220);                   //debugging string XD
	vagRounded.drawString(eventString, 0,150);
    
    ofSetColor(255, 255, 255);
        
    if (timeForShift < 0)                     //change map!  
    {
        stageNum = stageNext;
        stageNext = ofRandom(1, 5.99);
        timeForShift = ofRandom(20, 40) * stageNum;
        ofResetElapsedTimeCounter();
        elapsed = 0;
        roomstate = 0;
        room.loadImage("images/room.jpg");
    }


    sprintf(eventString, "StageNum %i\nstageNext %i\ntimeForShift %2.0f\nbunnypos[2] %d\nRoomstate %i", stageNum, stageNext, timeForShift, bunnyPos[2], roomstate);
        
    
    
}

//--------------------------------------------------------------
void testApp::exit(){
    
}

//--------------------------------------------------------------
void testApp::touchDown(ofTouchEventArgs & touch){
    touchdx = touch.x;

}

//--------------------------------------------------------------
void testApp::touchMoved(ofTouchEventArgs & touch){

}

//--------------------------------------------------------------
void testApp::touchUp(ofTouchEventArgs & touch){
    touchux = touchdx - touch.x;
    if (touchux > 0) { //swipe right
            roomstate++;
        if(roomstate >= stageNum) roomstate = stageNum;
            
    } else if (touchux < 0) {
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
