
#import <Foundation/Foundation.h>
#include <stdlib.h>
#include <math.h>
#import <OpenGL/OpenGL.h>
#import <GLUT/GLUT.h>
#include "gltools.h" // // gltools library link ( Normal 을 구하는 함수 구현 )


static GLfloat xRot = 0.0f;

static GLfloat yRot = 0.0f;

static GLfloat zDistance = 0.0f;

void DrawCube(void)
{
   
    glTranslatef( 0.0f, 0.0f, -5.0f);
    
    
    
    glRotatef(20.0f,1.0f,0.0f,0.0f);
    glRotatef(-20.0f,0.0f,1.0f,0.0f);
    
    
    glRotatef(xRot,1.0f,0.0f,0.0f);
    glRotatef(yRot,0.0f,1.0f,0.0f);
    
    
    glBegin( GL_QUADS );
    glColor3f(0.0f, 1.0f, 1.0f); glVertex3f(-1.0f, 1.0f, 1.0f); // { Front }
    glColor3f(0.0f, 1.0f, 0.0f); glVertex3f(-1.0f,-1.0f, 1.0f); // { Front }
    glColor3f(0.0f, 0.0f, 0.0f); glVertex3f( 1.0f,-1.0f, 1.0f); // { Front }
    glColor3f(0.0f, 0.0f, 1.0f); glVertex3f( 1.0f, 1.0f, 1.0f); // { Front }
    
    glColor3f(0.0f, 0.0f, 1.0f); glVertex3f( 1.0f, 1.0f, 1.0f); // { Right }
    glColor3f(0.0f, 0.0f, 0.0f); glVertex3f( 1.0f,-1.0f, 1.0f); // { Right }
    glColor3f(1.0f, 0.0f, 0.0f); glVertex3f( 1.0f,-1.0f,-1.0f); // { Right }
    glColor3f(1.0f, 0.0f, 1.0f); glVertex3f( 1.0f, 1.0f,-1.0f); // { Right }
    
    glColor3f(1.0f, 0.0f, 1.0f); glVertex3f( 1.0f, 1.0f,-1.0f); // { Back }
    glColor3f(1.0f, 0.0f, 0.0f); glVertex3f( 1.0f,-1.0f,-1.0f); // { Back }
    glColor3f(1.0f, 1.0f, 0.0f); glVertex3f(-1.0f,-1.0f,-1.0f); // { Back }
    glColor3f(1.0f, 1.0f, 1.0f); glVertex3f(-1.0f, 1.0f,-1.0f); // { Back }
    
    glColor3f(1.0f, 1.0f, 1.0f); glVertex3f(-1.0f, 1.0f,-1.0f); // { Left }
    glColor3f(1.0f, 1.0f, 0.0f); glVertex3f(-1.0f,-1.0f,-1.0f); // { Left }
    glColor3f(0.0f, 1.0f, 0.0f); glVertex3f(-1.0f,-1.0f, 1.0f); // { Left }
    glColor3f(0.0f, 1.0f, 1.0f); glVertex3f(-1.0f, 1.0f, 1.0f); // { Left }
    
    glColor3f(0.0f, 1.0f, 1.0f); glVertex3f(-1.0f, 1.0f, 1.0f); // { Top }
    glColor3f(0.0f, 0.0f, 1.0f); glVertex3f( 1.0f, 1.0f, 1.0f); // { Top }
    glColor3f(1.0f, 0.0f, 1.0f); glVertex3f( 1.0f, 1.0f,-1.0f); // { Top }
    glColor3f(1.0f, 1.0f, 1.0f); glVertex3f(-1.0f, 1.0f,-1.0f); // { Top }
    
    glColor3f(0.0f, 0.0f, 0.0f); glVertex3f( 1.0f,-1.0f, 1.0f); // { Bottom }
    glColor3f(0.0f, 1.0f, 0.0f); glVertex3f(-1.0f,-1.0f, 1.0f); // { Bottom }
    glColor3f(1.0f, 1.0f, 0.0f); glVertex3f(-1.0f,-1.0f,-1.0f); // { Bottom }
    glColor3f(1.0f, 0.0f, 0.0f); glVertex3f( 1.0f,-1.0f,-1.0f); // { Bottom }
    glEnd();
}

void SetupRC() {
    // Light values and coordinates
    GLfloat amb[] = {1.0f,1.0f,1.0f};
    glEnable(GL_DEPTH_TEST);
    glEnable(GL_CULL_FACE); // 내부 폴리곤 연산 off (backface culling)
    glFrontFace(GL_CCW);
    
    glEnable(GL_LIGHTING);
    
    glLightModelfv(GL_LIGHT_MODEL_AMBIENT, amb);
    glEnable(GL_COLOR_MATERIAL);
    glColorMaterial(GL_FRONT, GL_AMBIENT_AND_DIFFUSE);
    glClearColor(0.71f, 0.74f, 0.76f, 1.0f);
}

void RenderScene(void)
{
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
   
    glPushMatrix();
  
    glScalef(20, 20, 0);
    glTranslatef(0.0f,0.0f,zDistance);
    
    DrawCube();
    
    glPopMatrix();
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
    if(key == GLUT_KEY_HOME) {
        zDistance += 5.0f;
    }//add
    
    if(key == GLUT_KEY_END) {
        zDistance -= 5.0f;
    }//add
    glutPostRedisplay();
}

void ChangeSize(int w, int h) {
    GLfloat fAspect;
    GLfloat lightPos[] = { -50.f, 50.f, 100.0f, 1.0f };
    
    glViewport(0,0,w,h);
    fAspect = (GLfloat)w/(GLfloat)h;
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    
    gluPerspective(45.0f,fAspect,1.0f,255.0f);
    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
    
    glLightfv(GL_LIGHT0,GL_POSITION,lightPos);
    glTranslatef(0.0f,0.0f,-150.0f);
}

int main(int argc, char * argv[])
{
    glutInit(&argc,argv);
    glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB | GLUT_DEPTH);
    glutInitWindowPosition(0, 0);
    glutInitWindowSize(512, 512);
    glutCreateWindow("LIGHT JET");
    glutReshapeFunc(ChangeSize);
    glutSpecialFunc(ControlKey);
    glutDisplayFunc(RenderScene);
    SetupRC();
    glutMainLoop();
}
