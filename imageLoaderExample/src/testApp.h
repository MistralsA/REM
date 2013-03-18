#pragma once

#include "ofMain.h"
#include "ofxiPhone.h"
#include "ofxiPhoneExtras.h"

class testApp : public ofxiPhoneApp{
	
    public:
        void setup();
        void update();
        void draw();
        void exit();
    
        void touchDown(ofTouchEventArgs & touch);
        void touchMoved(ofTouchEventArgs & touch);
        void touchUp(ofTouchEventArgs & touch);
        void touchDoubleTap(ofTouchEventArgs & touch);
        void touchCancelled(ofTouchEventArgs & touch);
	
        void lostFocus();
        void gotFocus();
        void gotMemoryWarning();
        void deviceOrientationChanged(int newOrientation);
        void loadRoom();
        
        ofImage bunny;
        ofImage funny;
        ofImage bg;
        ofImage button;
        ofImage buttonglow;
        ofImage room;
        float timeForShift;
        int stageNum;
        int stageNext;
        int elapsed;
        int touchdx;
        int roomstate;
        int touchux;
        int bunnyPos[3];
                
        ofTrueTypeFont vagRounded;
        char eventString[255];

};
