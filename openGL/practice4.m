#include <Foundation/Foundation.h>
#include <math.h>
#include <OpenGL/OpenGL.h>
#include <GLUT/glut.h>
#include "SOIL.h"

#define GL_PI 3.14159f

static GLfloat xRot = 0.0f;
static GLfloat yRot = 0.0f;


static GLfloat zDistance = 0.0f;


//Light setting
GLfloat ambientLight[] = { 0.2f, 0.2f, 0.2f, 1.0f };
GLfloat nomat[] = { 0.05f, 0.05f, 0.05f, 1.0f };
GLfloat diffuseLight[] = { 1.0f, 1.0f, 1.0f, 1.0f };
GLfloat emissionLight[] = { 0.5f, 0.5f, 0.5f, 1.0f };


GLfloat lightPos[] = { 0.0f, 0.0f, 0.0f, 1.0f };
GLfloat specular[] = { 1.0f, 1.0f, 1.0f, 1.0f };
GLfloat specref[] = { 1.0f, 1.0f, 1.0f, 1.0f };

GLuint sunTex;
GLuint earthTex;
GLuint Tex3;
GLuint Tex4;

GLUquadricObj *pSphere;


GLuint LoadTexture(const char* filename,GLfloat param)
{
    GLuint texID = SOIL_load_OGL_texture(filename, SOIL_LOAD_AUTO, SOIL_CREATE_NEW_ID,
                                         SOIL_FLAG_MIPMAPS |
                                         SOIL_FLAG_INVERT_Y |
                                         SOIL_FLAG_NTSC_SAFE_RGB |
                                         SOIL_FLAG_COMPRESS_TO_DXT);
    glEnable(GL_TEXTURE_2D);
    glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, param);
    glBindTexture(GL_TEXTURE_2D, texID);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);
    
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR_MIPMAP_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR_MIPMAP_LINEAR);
    
    return texID;
}

void SetupRC(void) {
    
    glEnable(GL_DEPTH_TEST);
    glFrontFace(GL_CCW); // 반시계 방향 회전
    glEnable(GL_CULL_FACE); // hidden face 제거
    glEnable(GL_LIGHTING);
    glLightfv(GL_LIGHT0,GL_AMBIENT,ambientLight);
    glLightfv(GL_LIGHT0,GL_DIFFUSE,diffuseLight);
    glLightfv(GL_LIGHT0,GL_SPECULAR, specular);
    glEnable(GL_LIGHT0);
    glEnable(GL_COLOR_MATERIAL);
    
    pSphere = gluNewQuadric();
    gluQuadricDrawStyle(pSphere, GLU_FILL);
    gluQuadricNormals(pSphere, GLU_SMOOTH);
    gluQuadricTexture(pSphere, GLU_TRUE);
    
    
    glClearColor(0.0f,0.0f,0.0f,1.0f);
}

void TimerFunc(int value) {
    glutPostRedisplay();
    glutTimerFunc(100, TimerFunc, 1);
}



void InitTexture()
{
    sunTex = LoadTexture("resources/fire.jpeg",GL_BLEND);
    earthTex = LoadTexture("resources/texture.png",GL_MODULATE);
    Tex3 = LoadTexture("resources/ice.jpg",GL_REPLACE);
    Tex4 = LoadTexture("resources/TennisBallColorMap.jpg",GL_REPLACE);
}

void RenderScene(void) {
    
    static GLfloat fElect1 = 0.0f;
    static GLfloat fElect2 = 0.0f;
    
    glClear(GL_COLOR_BUFFER_BIT| GL_DEPTH_BUFFER_BIT);
    
    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
    glTranslatef(0.0f,0.0f,zDistance);
    glTranslatef(0.0f,0.0f,-200.0f);
    glLightfv(GL_LIGHT0, GL_POSITION, lightPos);

    glPushMatrix();
    //sun
    glEnable(GL_DEPTH_TEST);
    glColor3f(0.91, 0.29, 0.21);
    glBindTexture(GL_TEXTURE_2D, sunTex);
    glColorMaterial( GL_FRONT,GL_AMBIENT_AND_DIFFUSE);
    glMateriali(GL_FRONT, GL_SHININESS, 128);
    glMaterialfv(GL_FRONT, GL_EMISSION, emissionLight);
    glMaterialfv(GL_FRONT, GL_SPECULAR, specref); // add – specular
    glRotatef(xRot,1.0f,0.0f,0.0f);
    glRotatef(yRot,0.0f,1.0f,0.0f);
    gluSphere(pSphere, 20.0f, 18, 18);
  
    glPopMatrix();
    //podTex
    glPushMatrix();
    glRotatef(-45.0f, 0.0f, 0.0f, 1.0f);
    glRotatef(fElect1, 0.0f, 1.0f, 0.0f);
    glTranslatef(90.0f,0.0f, 0.0f);
    glColorMaterial( GL_FRONT,GL_DIFFUSE);
    glMateriali(GL_FRONT, GL_SHININESS, 50);
    glMaterialfv(GL_FRONT, GL_AMBIENT, nomat);
    glMaterialfv(GL_FRONT, GL_EMISSION, nomat);
    glMaterialfv(GL_FRONT, GL_SPECULAR, nomat);
    glColor3ub(255, 255, 255);
    glBindTexture(GL_TEXTURE_2D, Tex3);
    
    glutSolidTeapot(20.0f);
    glPopMatrix();

    //earth
    glRotatef(fElect1, 0.0f, 1.0f, 0.0f);
    glTranslatef(60.0f,0.0f, 0.0f);
    glBindTexture(GL_TEXTURE_2D, earthTex);
    glColorMaterial( GL_FRONT,GL_DIFFUSE);
    glMateriali(GL_FRONT, GL_SHININESS, 50);
    glMaterialfv(GL_FRONT, GL_AMBIENT, nomat);
    glMaterialfv(GL_FRONT, GL_EMISSION, nomat);
    glMaterialfv(GL_FRONT, GL_SPECULAR, nomat);
    glColor3f(0.71, 0.83, 0.91);
    gluSphere(pSphere, 8.0f, 18, 18);
    //moon
    glBindTexture(GL_TEXTURE_2D, Tex4);
    glRotatef(10.0f, 0.0f, 0.0f, 1.0f);
    glRotatef(fElect2, 0.0f, 1.0f, 0.0f);
    glTranslatef(-20.0f, 0.0f, 0.0f);
    glColor3f(0.97, 0.92, 0.65);
    gluSphere(pSphere, 3.0f, 18, 18);

    
    glPopMatrix();
   
    fElect1 += 10.0f;
    fElect2 += 30.0f;
    
    glEnable(GL_LIGHTING);
    glLightfv(GL_LIGHT0,GL_AMBIENT,ambientLight);
    glLightfv(GL_LIGHT0,GL_DIFFUSE,diffuseLight);
    glLightfv(GL_LIGHT0,GL_SPECULAR, specular);
    glEnable(GL_LIGHT0);
    glEnable(GL_COLOR_MATERIAL);
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

void NormalkeyInput(unsigned char key, int x, int y) {
    if (key == 'q')
        exit(-1);
}


int main(int argc,char * argv[])
{
    glutInit(&argc,argv);
    glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB | GLUT_DEPTH);
    glutInitWindowPosition(0, 0);
    glutInitWindowSize(512, 512);
    glutCreateWindow("TEXTURE");
    
    glutReshapeFunc(ChangeSize);
    glutSpecialFunc(ControlKey);
    glutDisplayFunc(RenderScene);
    
    glutKeyboardFunc(NormalkeyInput);
    InitTexture();
    glutTimerFunc(33,TimerFunc,1);
    
    SetupRC();
    glutMainLoop();
    return 0;
}