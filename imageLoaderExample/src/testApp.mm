#include "testApp.h"

//--------------------------------------------------------------
void testApp::setup(){	
	ofxiPhoneSetOrientation(OFXIPHONE_ORIENTATION_LANDSCAPE_RIGHT);
	
	bunny.loadImage("images/transparency.png");
    funny.loadImage("images/bike_icon.png");
    bg.loadImage("images/bg.png");
    button.loadImage("images/button.png");
    buttonglow.loadImage("images/buttonglow.png");
    vagRounded.loadFont("vag.ttf", 18);
    ofBackground(255, 255, 255);
    stageNum = 1;
    stageNext = ofRandom(1, 5);
    timeForShift = rand() % 40 * stageNum;
}

//-------------------------------------------------------------
void testApp::update(){
	timeForShift -= 0.05;
	//timeForShift -= 1;
}

//--------------------------------------------------------------
void testApp::draw(){	

	//ofScale(0.5, 0.5, 1.0);
    ofSetHexColor(0xFFFFFF);
        
	ofEnableAlphaBlending();
    ofSetColor(255,255,255,timeForShift*4);    //tranparency
	bunny.draw(sin(ofGetElapsedTimeMillis()/1000.0f) * 100 + 100,20);
	ofDisableAlphaBlending();

	ofSetColor(255,122,220);                   //debugging string XD
	vagRounded.drawString(eventString, 0,150);
    
    if (timeForShift < 0)                     //change map!  
    {
        stageNum = stageNext;
        stageNext = ofRandom(1, 5);
        timeForShift = ofRandom(20, 40) * stageNum;
    }
    ofSetColor(255, 255, 255);
    funny.draw(20*stageNum, 20*stageNext);
    sprintf(eventString, "StageNum %i\nstageNext %i\ntimeForShift %2.0f", stageNum, stageNext, timeForShift);
    
}

//--------------------------------------------------------------
void testApp::exit(){
    
}

//--------------------------------------------------------------
void testApp::touchDown(ofTouchEventArgs & touch){

}

//--------------------------------------------------------------
void testApp::touchMoved(ofTouchEventArgs & touch){

}

//--------------------------------------------------------------
void testApp::touchUp(ofTouchEventArgs & touch){
    
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
