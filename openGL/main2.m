
#import <Foundation/Foundation.h>
#include <stdlib.h>
#include <math.h>
#import <OpenGL/OpenGL.h>
#import <GLUT/GLUT.h>
#include "gltools.h" // // gltools library link ( Normal 을 구하는 함수 구현 )


static GLfloat xRot = 0.0f;

static GLfloat yRot = 0.0f;

static GLfloat zDistance = 0.0f;

void SetupRC() {
    // Light values and coordinates
    GLfloat amb[] = {0.3f,0.3f,0.3f};
    glEnable(GL_DEPTH_TEST);
    glEnable(GL_CULL_FACE); // 내부 폴리곤 연산 off (backface culling)
    glFrontFace(GL_CCW);
    
    glEnable(GL_LIGHTING);
    
    glLightModelfv(GL_LIGHT_MODEL_AMBIENT, amb);
    glEnable(GL_COLOR_MATERIAL);
    glColorMaterial(GL_FRONT, GL_AMBIENT_AND_DIFFUSE);
}
void DrawJet()
{
    GLTVector3 vNormal;	// Storeage for calculated surface normal
    
    glColor3ub(128,128,128);
    glBegin(GL_TRIANGLES);
    
    //front bottom
    glNormal3f(0.0f, -1.0f, 0.0f);
    
    //		glVertex3f(0.0f, 0.0f, 60.0f);
    //		glVertex3f(-15.0f, 0.0f, 30.0f);
    //		glVertex3f(15.0f,0.0f,30.0f);
    //		//¡÷ºÆ√≥∏Æ ¡¶∞≈
    
    //Right Winng
    GLTVector3 vPoints[3] = {{ 15.0f, 0.0f,  30.0f},
        { 0.0f,  15.0f, 30.0f},
        { 0.0f,  0.0f,  60.0f}};
    
    // Calculate the normal for the plane
    gltGetNormalVector(vPoints[0], vPoints[1], vPoints[2], vNormal);
    
    glNormal3fv(vNormal);
    glVertex3fv(vPoints[0]);
    glVertex3fv(vPoints[1]);
    glVertex3fv(vPoints[2]);
    
    {
        GLTVector3 vPoints[3] = {{ 0.0f, 0.0f, 60.0f },
            { 0.0f, 15.0f, 30.0f },
            { -15.0f, 0.0f, 30.0f }};
        
        gltGetNormalVector(vPoints[0], vPoints[1], vPoints[2], vNormal);
        glNormal3fv(vNormal);
        glVertex3fv(vPoints[0]);
        glVertex3fv(vPoints[1]);
        glVertex3fv(vPoints[2]);
    }
    
    
    // Body of the Plane ////////////////////////
    {
        GLTVector3 vPoints[3] = {{ -15.0f, 0.0f, 30.0f },
            { 0.0f, 15.0f, 30.0f },
            { 0.0f, 0.0f, -56.0f }};
        
        gltGetNormalVector(vPoints[0], vPoints[1], vPoints[2], vNormal);
        glNormal3fv(vNormal);
        glVertex3fv(vPoints[0]);
        glVertex3fv(vPoints[1]);
        glVertex3fv(vPoints[2]);
    }
    
    {
        GLTVector3 vPoints[3] = {{ 0.0f, 0.0f, -56.0f },
            { 0.0f, 15.0f, 30.0f },
            { 15.0f,0.0f,30.0f }};
        
        gltGetNormalVector(vPoints[0], vPoints[1], vPoints[2], vNormal);
        glNormal3fv(vNormal);
        glVertex3fv(vPoints[0]);
        glVertex3fv(vPoints[1]);
        glVertex3fv(vPoints[2]);
    }
    
    
    glNormal3f(0.0f, -1.0f, 0.0f);
    glVertex3f(15.0f,0.0f,30.0f);
    glVertex3f(-15.0f, 0.0f, 30.0f);
    glVertex3f(0.0f, 0.0f, -56.0f);
    
    ///////////////////////////////////////////////
    // Left wing
    // Large triangle for bottom of wing
    {
        GLTVector3 vPoints[3] = {{ 0.0f,2.0f,27.0f },
            { -60.0f, 2.0f, -8.0f },
            { 60.0f, 2.0f, -8.0f }};
        
        gltGetNormalVector(vPoints[0], vPoints[1], vPoints[2], vNormal);
        glNormal3fv(vNormal);
        glVertex3fv(vPoints[0]);
        glVertex3fv(vPoints[1]);
        glVertex3fv(vPoints[2]);
    }
    
    
    {
        GLTVector3 vPoints[3] = {{ 60.0f, 2.0f, -8.0f},
            {0.0f, 7.0f, -8.0f},
            {0.0f,2.0f,27.0f }};
        
        gltGetNormalVector(vPoints[0], vPoints[1], vPoints[2], vNormal);
        glNormal3fv(vNormal);
        glVertex3fv(vPoints[0]);
        glVertex3fv(vPoints[1]);
        glVertex3fv(vPoints[2]);
    }
    
    {
        GLTVector3 vPoints[3] = {{60.0f, 2.0f, -8.0f},
            {-60.0f, 2.0f, -8.0f},
            {0.0f,7.0f,-8.0f }};
        
        gltGetNormalVector(vPoints[0], vPoints[1], vPoints[2], vNormal);
        glNormal3fv(vNormal);
        glVertex3fv(vPoints[0]);
        glVertex3fv(vPoints[1]);
        glVertex3fv(vPoints[2]);
    }
    
    {
        GLTVector3 vPoints[3] = {{0.0f,2.0f,27.0f},
            {0.0f, 7.0f, -8.0f},
            {-60.0f, 2.0f, -8.0f}};
        
        gltGetNormalVector(vPoints[0], vPoints[1], vPoints[2], vNormal);
        glNormal3fv(vNormal);
        glVertex3fv(vPoints[0]);
        glVertex3fv(vPoints[1]);
        glVertex3fv(vPoints[2]);
    }
    
    
    // Tail section///////////////////////////////
    // Bottom of back fin
    glNormal3f(0.0f, -1.0f, 0.0f);
    glVertex3f(-30.0f, -0.50f, -57.0f);
    glVertex3f(30.0f, -0.50f, -57.0f);
    glVertex3f(0.0f,-0.50f,-40.0f);
    
    {
        GLTVector3 vPoints[3] = {{ 0.0f,-0.5f,-40.0f },
            {30.0f, -0.5f, -57.0f},
            {0.0f, 4.0f, -57.0f }};
        
        gltGetNormalVector(vPoints[0], vPoints[1], vPoints[2], vNormal);
        glNormal3fv(vNormal);
        glVertex3fv(vPoints[0]);
        glVertex3fv(vPoints[1]);
        glVertex3fv(vPoints[2]);
    }
    
    
    {
        GLTVector3 vPoints[3] = {{ 0.0f, 4.0f, -57.0f },
            { -30.0f, -0.5f, -57.0f },
            { 0.0f,-0.5f,-40.0f }};
        
        gltGetNormalVector(vPoints[0], vPoints[1], vPoints[2], vNormal);
        glNormal3fv(vNormal);
        glVertex3fv(vPoints[0]);
        glVertex3fv(vPoints[1]);
        glVertex3fv(vPoints[2]);
    }
    
    
    {
        GLTVector3 vPoints[3] = {{ 30.0f,-0.5f,-57.0f },
            { -30.0f, -0.5f, -57.0f },
            { 0.0f, 4.0f, -57.0f }};
        
        gltGetNormalVector(vPoints[0], vPoints[1], vPoints[2], vNormal);
        glNormal3fv(vNormal);
        glVertex3fv(vPoints[0]);
        glVertex3fv(vPoints[1]);
        glVertex3fv(vPoints[2]);
    }
    
    {
        GLTVector3 vPoints[3] = {{ 0.0f,0.5f,-40.0f },
            { 3.0f, 0.5f, -57.0f },
							     { 0.0f, 25.0f, -65.0f }};
        
        gltGetNormalVector(vPoints[0], vPoints[1], vPoints[2], vNormal);
        glNormal3fv(vNormal);
        glVertex3fv(vPoints[0]);
        glVertex3fv(vPoints[1]);
        glVertex3fv(vPoints[2]);
    }
    
    {
        GLTVector3 vPoints[3] = {{ 0.0f, 25.0f, -65.0f },
            { -3.0f, 0.5f, -57.0f},
            { 0.0f,0.5f,-40.0f }};
        
        gltGetNormalVector(vPoints[0], vPoints[1], vPoints[2], vNormal);
        glNormal3fv(vNormal);
        glVertex3fv(vPoints[0]);
        glVertex3fv(vPoints[1]);
        glVertex3fv(vPoints[2]);
    }
    
    {
        GLTVector3 vPoints[3] = {{ 3.0f,0.5f,-57.0f },
            { -3.0f, 0.5f, -57.0f },
            { 0.0f, 25.0f, -65.0f }};
        
        gltGetNormalVector(vPoints[0], vPoints[1], vPoints[2], vNormal);
        glNormal3fv(vNormal);
        glVertex3fv(vPoints[0]);
        glVertex3fv(vPoints[1]);
        glVertex3fv(vPoints[2]);
    }
    glEnd();
}

void RenderScene(void)
{
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    glPushMatrix();
    
    glRotatef(xRot,1.0f,0.0f,0.0f);
    glRotatef(yRot,0.0f,1.0f,0.0f);
    
    glTranslatef(0.0f,0.0f,zDistance);
    
    DrawJet();
    
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
        ytRot -= 5.0f;
    }
    if(key == GLUT_KEY_RIGHT){
        ytRot += 5.0f;
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
