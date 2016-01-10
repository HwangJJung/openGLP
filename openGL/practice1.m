

#import <Foundation/Foundation.h>
#import <OpenGL/OpenGL.h>
#import <GLUT/GLUT.h>

//정사각형의 위치와 크기의 초기값 설정

GLsizei rsize = 50.0f;

// 윈도우 크기 선언
GLfloat window_width;
GLfloat window_height;

struct RectPoint {
    GLfloat x;
    GLfloat y;
    float rgb[3];
    
    GLfloat xstep;
    GLfloat ystep;

};


const int MAX= 4;

struct RectPoint rects[MAX] = {
    { -50.0f, 0.0f, {0.96, 0.76, 0.73}, 1.0f, 1.0f},
    { 50.0f, 0.0f, {0.71, 0.93, 0.8}, 1.0f, 1.0f},
    { -125.0f, -75.0f, {0.97, 0.92, 0.65}, 1.0f, 1.0f},
    { 25.0f, -75.0f, {0.87, 0.77, 0.91}, 1.0f, 1.0f},

};

struct RectPoint *rp[MAX] = {
 &rects[0],
 &rects[1],
 &rects[2],
 &rects[3],
};

void RenderScene(void) {
    glClear(GL_COLOR_BUFFER_BIT);
    for (int i =0; i<MAX; i++) {
        glColor3f(rects[i].rgb[0],rects[i].rgb[1],rects[i].rgb[2]);
        glRectf(rects[i].x,rects[i].y,rects[i].x+rsize,rects[i].y+rsize);
        glColor3f(0,0,0);
    }
    //사각형의 생성
    glutSwapBuffers(); //드로잉 실행 후 버퍼 교체
}

void TimerFunction(int value) //callback
{
    for (int i =0; i<MAX; i++) {
//        struct RectPoint *p = &rects[i];
//        //x축 범위 (window 안에서 돌아나니도록 설정)
        if(rp[i]->x + rsize  > window_width || rp[i]->x < -window_width)
            rp[i]->xstep = -rp[i]->xstep;
        //y축 범위 (window 안에서 돌아다니도록 설정)
        if(rp[i]->y + rsize > window_height || rp[i]->y < -window_height)
            rp[i]->ystep = -rp[i]->ystep;
        
        //윈도우가 변경되어 경계를 넘어갔을 때
        if(rp[i]->x > window_width-rsize)
            rp[i]->x = window_width-rsize -1;
        if(rp[i]->y > window_height-rsize)
            rp[i]->y = window_height - rsize -1;
//        
        //다른 rect랑 부딪혔을때
        for(int j=0; j<MAX; j++) {
            if(i!=j) {
                //x방향 확인
                if(rp[i]->x + rsize >rp[j]->x && rp[i]->x < rp[j]->x +rsize) {
                    if(rp[i]->y + rsize > rp[j]->y && rp[i]->y < rp[j]->y + rsize) {
                        rp[i]->xstep = -rp[i]->xstep;
                        rp[j]->xstep = -rp[j]->xstep;
                    }
                    
                }
                //y방향 확인
                if(rp[i]->y + rsize > rp[j]->y && rp[i]->y < rp[j]->y + rsize) {
                    if(rp[i]->x + rsize >rp[j]->x && rp[i]->x < rp[j]->x +rsize) {
                        rp[i]->ystep = -rp[i]->ystep;
                        rp[j]->ystep = -rp[j]->ystep;
                    
                    }
                }
            }
        }
        
        rp[i]->x += rp[i]->xstep;
        rp[i]->y += rp[i]->ystep;
    }
    
    glutPostRedisplay();
    glutTimerFunc(22, TimerFunction,1);
}

void SetupRC(void) {
    glClearColor(0.91, 0.92, 0.93, 1.0f);
}


void ChangeSize(GLsizei w, GLsizei h)
{
    GLfloat nRange = 100.0f;
    glViewport(0, 0, w, h);
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    if(w<=h)
    {
        window_width = nRange;
        window_height = nRange*h/w;
        glOrtho(-nRange, nRange, -window_height, window_height, 1.0, -1.0);
    }
    else {
        window_width = nRange*w/h;
        window_height = nRange;
        glOrtho(-window_width, window_width, -nRange, nRange, 1.0, -1.0);
    }
    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
}

int main(int argc,char * argv[])
{
    glutInit(&argc,argv);
    glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB);
    glutInitWindowPosition(0, 0);
    glutInitWindowSize(800, 600);
    glutCreateWindow("BounceRectangle");
   //    glutSpecialFunc(KeyControl);
    glutDisplayFunc(RenderScene);
    glutReshapeFunc(ChangeSize);
    glutTimerFunc(2000,TimerFunction,1);
    
    SetupRC();
    glutMainLoop();
    return 0;
}