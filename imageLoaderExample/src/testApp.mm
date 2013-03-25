#include "testApp.h"

//--------------------------------------------------------------
void testApp::setup(){	
	ofxiPhoneSetOrientation(OFXIPHONE_ORIENTATION_LANDSCAPE_RIGHT);
	
    bunny.loadImage("images/bunny0.png");
    cat.loadImage("images/cat.png");
    pillow.loadImage("images/pillow.png");
    room.loadImage("images/room10.png");
    //vagRounded.loadFont("vag.ttf", 18);
    ofBackground(255, 255, 255);
    stageNum = 0;
    stageNext = 1;
    roomstate = 0;
    timeForShift = rand() % 40 * 1;
    elapsed = 0;
    //bunnyPos[0] = ofRandom(0, 824); //bunny x
    //bunnyPos[1] = ofRandom(0, 568); //bunny y
    //bunnyPos[2] = ofRandom(-stageNum-.99, stageNum+.99);  //bunny room location
    catPos[0] = ofRandom(0,824); //cat x
    catPos[1] = ofRandom(0,568); //cat y
    catPos[2] = 5; //cat room location (always in 5)
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
    
    if (stageNum == 0)              //START MENU YO
    {
        ofEnableAlphaBlending();
        ofSetColor(255, 255, 255);
        room.loadImage("images/menu.png");
        room.draw(0, 0, 1024, 768);
        pillow.draw(450, 400);  //150 x 100
        ofDisableAlphaBlending();
        playSound();
    }

    if (timeForShift > 0 && stageNum != 0) {
        ofSetHexColor(0xFFFFFF);
        ofEnableAlphaBlending();
    
        ofSetColor(255,255,255,timeForShift*4);    // Room transparency
        room.draw(0,0, 1024, 768);
    
        if (elapsed % 2000 <= 20)   //time before bunny jumps (in milli)
        {
            bunnyPos[0] = ofRandom(0, 824);
            bunnyPos[1] = ofRandom(0, 568);
            bunnyPos[2] = ofRandom(-stageNum-.99,stageNum+.99);
        }
        
        if (roomstate == catPos[2]) {                   //cat location
            ofSetColor(255, 255, 255, 255);
            cat.draw(catPos[0], catPos[1]);
        }
    
        if (roomstate == bunnyPos[2]) {
            ofSetColor(255,255,255,255-(elapsed % 2000)/8);    // Bunny transparency
            bunny.draw(bunnyPos[0], bunnyPos[1]);
        }
        
        ofDisableAlphaBlending();
        //ofSetColor(255,122,220);                   //debugging string XD
        //vagRounded.drawString(eventString, 0,150);
        //ofSetColor(255, 255, 255);
        
        //sprintf(eventString, "StageNum %i\nstageNext %i\ntimeForShift %2.0f\nbunnypos[2] %d\nRoomstate %i", stageNum, stageNext, timeForShift, bunnyPos[2], roomstate);
    
    }
    


    if (timeForShift < 0 && stageNum != 0)          //GAME OVER
    {
        playSound();
        stageNum = 6;
        roomstate = 0;
        ofEnableAlphaBlending();
        ofSetColor(255, 255, 255);
        room.loadImage("images/gameover.png");
        room.draw(0, 0, 1024, 768);
        pillow.draw(450, 400);      //150 x 100
        ofDisableAlphaBlending();
    }

    
}

//--------------------------------------------------------------
void testApp::testShift()
{
    //change map!
    stageNum = stageNext;
    stageNext = ofRandom(1, 5.99);
    timeForShift = ofRandom(20, 40) * stageNum;
    ofResetElapsedTimeCounter();
    elapsed = 0;
    roomstate = 0;
    loadRoom();
    bunnyPos[0] = ofRandom(0, 824);
    bunnyPos[1] = ofRandom(0, 568);
    bunnyPos[2] = ofRandom(-stageNum-.99,stageNum+.99);
    bunnyImage();
    bunny.draw(bunnyPos[0], bunnyPos[1]);
    playSound();
    
}

//--------------------------------------------------------------
void testApp::bunnyImage()
{
    if (stageNum == 1)
        bunny.loadImage("images/bunny1.png");
    else if (stageNum == 2)
        bunny.loadImage("images/bunny2.png");
    else if (stageNum == 3)
        bunny.loadImage("images/bunny3.png");
    else if (stageNum == 4)
        bunny.loadImage("images/bunny4.png");
    else if (stageNum == 5)
        bunny.loadImage("images/bunny5.png");
}

//--------------------------------------------------------------
void testApp::playSound()
{
    song.unloadSound();     //rejects it out

    if (stageNum == 0)              //MENU SONG
        song.loadSound("music/sound0.mp3");
    else if (stageNum == 1)         //GAME SONG
        song.loadSound("music/sound1.mp3");
    else if (stageNum == 6)         //GAME OVER SONG
        song.loadSound("music.sound2.mp3");
    
    song.setLoop(TRUE);
    song.play();
}

//--------------------------------------------------------------
void testApp::exit(){
    
}

//--------------------------------------------------------------
void testApp::touchDown(ofTouchEventArgs & touch){
    touchdx = (int) touch.x;
    int ny = (int) touch.y;
    
    int rectTL[2];
    int rectBR[2];
                                                    //PRESS BUNNY
    rectTL[0] = bunnyPos[0];
    rectTL[1] = bunnyPos[1];
    
    rectBR[0] = bunnyPos[0] + 100;
    rectBR[1] = bunnyPos[1] + 100;
    
    if((touchdx>rectTL[0] && touchdx < rectBR[0]) && (ny > rectTL[1] && ny < rectBR[1]) && (stageNum != 6)
       && (stageNum != 0)){
        testShift();
    }
    
    rectTL[0] = catPos[0];
    rectTL[1] = catPos[1];
                                                    //PRESS CAT
    rectBR[0] = catPos[0] + 100;
    rectBR[1] = catPos[1] + 100;
    
    if((touchdx>rectTL[0] && touchdx < rectBR[0]) && (ny > rectTL[1] && ny < rectBR[1]) && (stageNum != 6)
       && (stageNum != 0)){
        //DO SOMETHING
    }
    
    
    if (stageNum == 6 || stageNum == 0) {               //PRESSED THE PILLOW
        rectTL[0] = 450;
        rectTL[1] = 400;
        rectBR[0] = 600;
        rectBR[1] = 500;
        
        if((touchdx>rectTL[0] && touchdx < rectBR[0]) && (ny > rectTL[1] && ny < rectBR[1])){
            stageNext = 1;
            testShift();
        }
    }

}

//--------------------------------------------------------------
void testApp::touchMoved(ofTouchEventArgs & touch){

}

//--------------------------------------------------------------
void testApp::touchUp(ofTouchEventArgs & touch){
    touchux = touchdx - (int) touch.x;
    if (touchux > 60) { //swipe right
            roomstate++;
        if(roomstate >= stageNum) roomstate = stageNum;
            
    } else if (touchux < -60) {
        roomstate--;
        if(roomstate <= -stageNum) roomstate = -stageNum;
    }
    //ofLog(OF_LOG_NOTICE, "touchux = %d", touchux);
    loadRoom();
    
}

//--------------------------------------------------------------
void testApp::loadRoom()
{
    switch (roomstate) {
        case -5:            // -5-5-5-5-5-5-5-5-5-5-5-5-5-5-5-5-5-5-5-5-5-5-5-5-5-5-5-5-5-5-5-5-5
            if (stageNum == -5)
                room.loadImage("images/room5-5.png");
            break;
        case -4:            // -4-4-4-4-4-4-4-4-4-4-4-4-4-4-4-4-4-4-4-4-4-4-4-4-4-4-4-4-4-4-4-4-4
            if (stageNum == -4)
                room.loadImage("images/room4-4.png");
            else if (stageNum == -5)
                room.loadImage("images/room5-4.png");
            break;
        case -3:            // -3-3-3-3-3-3-3-3-3-3-3-3-3-3-3-3-3-3-3-3-3-3-3-3-3-3-3-3-3-3-3-3-3
            if (stageNum == -3)
                room.loadImage("images/room3-3.png");
            else if (stageNum == -4)
                room.loadImage("images/room4-3.png");
            else if (stageNum == -5)
                room.loadImage("images/room5-3.png");
            break;
        case -2:            // -2-2-2-2-2-2-2-2-2-2-2-2-2-2-2-2-2-2-2-2-2-2-2-2-2-2-2-2-2-2-2-2-2
            if (stageNum == -2)
                room.loadImage("images/room2-2.png");
            else if (stageNum == -3)
                room.loadImage("images/room3-2.png");
            else if (stageNum == -4)
                room.loadImage("images/room4-2.png");
            else if (stageNum == -5)
                room.loadImage("images/room5-2.png");
            break;
        case -1:            // -1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1
            if (stageNum == -1)
                room.loadImage("images/room1-1.png");
            else if (stageNum == -2)
                room.loadImage("images/room2-1.png");
            else if (stageNum == -3)
                room.loadImage("images/room3-1.png");
            else if (stageNum == -4)
                room.loadImage("images/room4-1.png");
            else if (stageNum == -5)
                room.loadImage("images/room5-1.png");
            break;
        case 0:             // 00000000000000000000000000000000000000000000000000000000000000
            if (stageNum == 1)
                room.loadImage("images/room10.png");
            else if (stageNum == 2)
                room.loadImage("images/room20.png");
            else if (stageNum == 3)
                room.loadImage("images/room30.png");
            else if (stageNum == 4)
                room.loadImage("images/room40.png");
            else if (stageNum == 5)
                room.loadImage("images/room50.png");
            break;
        case 1:           // 1111111111111111111111111111111111111111111111111111111111111111
            if (stageNum == 1)
                room.loadImage("images/room11.png");
            else if (stageNum == 2)
                room.loadImage("images/room21.png");
            else if (stageNum == 3)
                room.loadImage("images/room31.png");
            else if (stageNum == 4)
                room.loadImage("images/room41.png");
            else if (stageNum == 5)
                room.loadImage("images/room51.png");
            break;
        case 2:           // 222222222222222222222222222222222222222222222222222222222222222
            if (stageNum == 2)
                room.loadImage("images/room22.png");
            else if (stageNum == 3)
                room.loadImage("images/room32.png");
            else if (stageNum == 4)
                room.loadImage("images/room42.png");
            else if (stageNum == 5)
                room.loadImage("images/room52.png");
            break;
        case 3:           // 333333333333333333333333333333333333333333333333333333333333333
            if (stageNum == 3)
                room.loadImage("images/room33.png");
            else if (stageNum == 4)
                room.loadImage("images/room43.png");
            else if (stageNum == 5)
                room.loadImage("images/room53.png");
            break;
        case 4:           // 44444444444444444444444444444444444444444444444444444444444444
            if (stageNum == 4)
                room.loadImage("images/room44.png");
            else if (stageNum == 5)
                room.loadImage("images/room54.png");
            break;
        case 5:           // 55555555555555555555555555555555555555555555555555555555555555
            if (stageNum == 5)
                room.loadImage("images/room55.png");
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
