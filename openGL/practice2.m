

#import <Foundation/Foundation.h>
#import <OpenGL/OpenGL.h>
#import <GLUT/GLUT.h>

#include <math.h>

#define GL_PI 3.1415f

static GLfloat xRot = 0.0f;
static GLfloat yRot = 0.0f;


// 윈도우 크기 선언
GLfloat window_width;
GLfloat window_height;



void SetupRC(void) {
    glClearColor(0.0f,0.0f,0.0f,1.0f);
    glEnable(GL_DEPTH_TEST);
    glFrontFace(GL_CCW); // 반시계 방향 회전
    glEnable(GL_CULL_FACE); // hidden face 제거
    
}

void TimerFunc(int value) {
    glutPostRedisplay();
    glutTimerFunc(100, TimerFunc, 1);
}


void RenderScene(void) {
    static GLfloat fElect1 = 0.0f;
    glClear(GL_COLOR_BUFFER_BIT| GL_DEPTH_BUFFER_BIT);

    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
    glTranslatef(0.0f,0.0f,-100.0f);
    
    glColor3f(0.96, 0.76, 0.73);
    glutSolidSphere(10.0f, 15, 15);
    
    glPushMatrix();
    glRotatef(fElect1, 0.0f, 1.0f, 0.0f);
    glTranslatef(90.0f,0.0f, 0.0f);
    glColor3f( 0.87, 0.77, 0.91);
    glutSolidSphere(6.0f, 15, 15);
    glPopMatrix();
    
    glPushMatrix();
    glRotatef(45.0f, 0.0f, 0.0f, 1.0f);
    glRotatef(fElect1, 0.0f, 1.0f, 0.0f);
    glTranslatef(-70.0f, 0.0f, 0.0f);
    glutSolidSphere(6.0f, 15, 15);
    glPopMatrix();
    
    glPushMatrix();
    glRotatef(90.0f, 0.0f, 0.0f, 1.0f);
    glRotatef(fElect1, 0.0f, 1.0f, 0.0f);
    glTranslatef(0.0f, 0.0f, 60.0f);
    glutSolidSphere(6.0f, 15, 15);
    glPopMatrix();
    
    fElect1 += 10.0f;
    glutSwapBuffers();
    
}


/////////////////////////////////////////////////////
// Handle arrow keys
void ControlKey(int key, int x, int y)
{
    if(key == GLUT_KEY_UP){
        xRot -= 5.0f;
    }
    
    if(key == GLUT_KEY_DOWN){
        xRot += 5.0f;
    }
    
    if(key == GLUT_KEY_LEFT) {
        yRot -= 5.0f;
    }
    if(key == GLUT_KEY_RIGHT){
        yRot += 5.0f;
    }
//    if(key == GLUT_KEY_HOME) {
//        zDistance += 5.0f;
//    }//add
//    
//    if(key == GLUT_KEY_END) {
//        zDistance -= 5.0f;
//    }//add
    glutPostRedisplay();
}



void ChangeSize(GLsizei w, GLsizei h)
{
    GLfloat fAspect;
    glViewport(0, 0, w, h);
    
    fAspect = (GLfloat)w/(GLfloat)h;
    
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
   
    gluPerspective(60.0f, fAspect, 1.0f, 500.0f);
    
    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
    
    glTranslatef(0.0f, 0.0f, -200.0f);
}

int main(int argc,char * argv[])
{
    glutInit(&argc,argv);
    glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB | GLUT_DEPTH);
    glutInitWindowPosition(0, 0);
    glutInitWindowSize(512, 512);
    glutCreateWindow("ATOM");
    
    glutReshapeFunc(ChangeSize);
    glutSpecialFunc(ControlKey);
    glutDisplayFunc(RenderScene);
    
    glutTimerFunc(33,TimerFunc,1);
    
    SetupRC();
    glutMainLoop();
    return 0;
}