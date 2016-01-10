

#import <Foundation/Foundation.h>
#import <OpenGL/OpenGL.h>
#import <GLUT/GLUT.h>

#include <math.h>

#define GL_PI 3.1415f

static GLfloat xRot = 0.0f;
static GLfloat yRot = 0.0f;

static GLfloat zDistance = 0.0f;




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
    static GLfloat fElect2 = 0.0f;
    
    glClear(GL_COLOR_BUFFER_BIT| GL_DEPTH_BUFFER_BIT);
    
     glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
    glRotatef(xRot,1.0f,0.0f,0.0f);
    glRotatef(yRot,0.0f,1.0f,0.0f);
    glTranslatef(0.0f,0.0f,zDistance);
    glTranslatef(0.0f,0.0f,-200.0f);
    
    //sun
    glColor3f(0.92, 0.73, 0.71);
   
    glutSolidSphere(10.0f, 15, 15);
    
    //earth
    glPushMatrix();
    glRotatef(fElect1, 0.0f, 1.0f, 0.0f);
    glTranslatef(60.0f,0.0f, 0.0f);
    glColor3f(0.71, 0.83, 0.91);
    glutSolidSphere(8.0f, 15, 15);
    
    
    //moon
    glPushMatrix();
    glRotatef(10.0f, 0.0f, 0.0f, 1.0f);
    glRotatef(fElect2, 0.0f, 1.0f, 0.0f);
    glTranslatef(-20.0f, 0.0f, 0.0f);
    glColor3f(0.97, 0.92, 0.65);
    glutSolidSphere(3.0f, 15, 15);
    glPopMatrix();

    glPopMatrix();
    
//    glPushMatrix();
//    glRotatef(90.0f, 0.0f, 0.0f, 1.0f);
//    glRotatef(fElect1, 0.0f, 1.0f, 0.0f);
//    glTranslatef(0.0f, 0.0f, 60.0f);
//    glutSolidSphere(6.0f, 15, 15);
//    glPopMatrix();
    
    fElect1 += 10.0f;
    fElect2 += 30.0f;
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
    if(key == GLUT_KEY_F1) {
        zDistance += 5.0f;
    }//add
    
    if(key == GLUT_KEY_F2) {
        zDistance -= 5.0f;
    }//add

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