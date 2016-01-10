//
//  main.cpp
//  TextureMapping
//
//  Created by fodrh1201 on 2016. 1. 4..
//  Copyright © 2016년 fodrh1201. All rights reserved.
//

#include <iostream>
#include <OpenGL/OpenGL.h>
#include <GLUT/glut.h>
#include <math.h>
#include "SOIL.h"

#define GL_PI 3.14592f
static GLfloat xRot = 0.0f;
static GLfloat yRot = 0.0f;
static GLfloat z_dist = 0.0f;

float sunRotate = 0.0f;
float fElect1 = 0.0f;
float fElect2 = 0.0f;
GLUquadricObj *pSphere = nullptr;

GLuint earthTex;
GLuint sunTex;
GLuint moonTex;

GLuint LoadTexture(const char* filename)
{
    GLuint texID = SOIL_load_OGL_texture(filename, SOIL_LOAD_AUTO, SOIL_CREATE_NEW_ID,
                                         SOIL_FLAG_MIPMAPS |
                                         SOIL_FLAG_INVERT_Y |
                                         SOIL_FLAG_NTSC_SAFE_RGB |
                                         SOIL_FLAG_COMPRESS_TO_DXT);
    glEnable(GL_TEXTURE_2D);
    glBindTexture(GL_TEXTURE_2D, texID);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);
    
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR_MIPMAP_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR_MIPMAP_LINEAR);
    
    return texID;
}

void SetupRC()
{
    glClearColor(0.0f, 0.0f, 0.0f, 1.0f);
    glColor3f(0.0f, 1.0f, 0.0f);
    glEnable(GL_DEPTH_TEST);
    glFrontFace(GL_CCW);
    glEnable(GL_CULL_FACE);
    
    glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_MODULATE);
    
    pSphere = gluNewQuadric();
    gluQuadricDrawStyle(pSphere, GLU_FILL);
    gluQuadricNormals(pSphere, GLU_SMOOTH);
    gluQuadricTexture(pSphere, GLU_TRUE);
}

void InitTexture()
{
    sunTex = LoadTexture("resources/sun.bmp");
    earthTex = LoadTexture("resources/earth.bmp");
    moonTex = LoadTexture("resources/moon.bmp");
}

void TimerFunc(int value)
{
    glutPostRedisplay();
    glutTimerFunc(100, TimerFunc, 1);
}

void SetLight(GLfloat* amb, GLfloat* diff)
{
    glEnable(GL_LIGHTING);
    glLightfv(GL_LIGHT0, GL_AMBIENT, amb);
    glLightfv(GL_LIGHT0, GL_DIFFUSE, diff);
    glEnable(GL_LIGHT0);
    glEnable(GL_COLOR_MATERIAL);
    glColorMaterial(GL_FRONT, GL_AMBIENT_AND_DIFFUSE);
}

void RenderScene()
{
    GLfloat amb[] = { 1.0f, 1.0f, 1.0f };
    GLfloat diff[] = { 1.0f, 1.0f, 1.0f };
    
    SetLight(amb, diff);
    
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
    glPushMatrix();
    
    glEnable(GL_TEXTURE_2D);
    glEnable(GL_DEPTH_TEST);
    glBindTexture(GL_TEXTURE_2D, sunTex);
    glRotatef(sunRotate, 0.0f, 1.0f, 0.0f);
    glColor3ub(255, 255, 255);
    gluSphere(pSphere, 20.0f, 18, 18);
    
    GLfloat amb2[] = { 0.03f, 0.03f, 0.03f };
    SetLight(amb2, diff);
    
    glBindTexture(GL_TEXTURE_2D, earthTex);
    glPopMatrix();
    
    glRotatef(fElect1, 0.0f, 1.0f, 0.0f);
    glTranslatef(90.0f, 0.0f, 0.0f);
    glColor3ub(255, 255, 255);
    gluSphere(pSphere, 6.0, 18, 18);
    
    glBindTexture(GL_TEXTURE_2D, moonTex);
    glRotatef(fElect2, 0.0f, 1.0f, 0.0f);
    glTranslatef(10.0f, 0.0f, 0.0f);
    glColor3ub(255, 255, 255);
    gluSphere(pSphere, 2.0f, 18, 18);
    
    sunRotate += 5.0f;
    fElect1 += 5.0f;
    fElect2 += 60.0f;
    
    if (sunRotate > 360.0f)
        sunRotate = 0.0f;
    
    if (fElect1 > 360.0f)
        fElect1 = 0.0f;
    
    if (fElect2 > 360.0f)
        fElect2 = 0.0f;
    
    glPopMatrix();
    glutSwapBuffers();
}

void KeyControl(int key, int x, int y)
{
    if (key == GLUT_KEY_UP)
        xRot -= 5.0f;
    
    if (key == GLUT_KEY_DOWN)
        xRot += 5.0f;
    
    if (key == GLUT_KEY_LEFT)
        yRot -= 5.0f;
    
    if (key == GLUT_KEY_RIGHT)
        yRot += 5.0f;
    
    if (key == GLUT_KEY_PAGE_UP)
        z_dist += 5.0f;
    
    if (key == GLUT_KEY_PAGE_DOWN)
        z_dist -= 5.0f;
    
    glutPostRedisplay();
}

void NormalKeyInput(unsigned char key, int x, int y)
{
    if (key == 'q')
        _exit(-1);
}

void ChangeSize(int w, int h)
{
    GLfloat lightPos[] = {0.0f, 0.0f, z_dist, 1.0f};
    GLfloat nRange = 100.0f;
    glViewport(0,0,w,h);
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    if(w <= h)
    {
        glOrtho(-nRange,nRange,-nRange*h/w,nRange*h/w, -nRange*2.0f, nRange*2.0f);
    }
    else
    {
        glOrtho(-nRange*w/h,nRange*w/h,-nRange,nRange, -nRange*2.0f,nRange*2.0f);
    }
    glLightfv(GL_LIGHT0, GL_POSITION,lightPos);
    
    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
}

int main(int argc, char * argv[]) {

    glutInit(&argc, argv);
    glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB | GLUT_DEPTH);
    glutInitWindowSize(800,800);
    glutInitWindowPosition(0,0);
    glutCreateWindow("Solar system with texture");
    glutSpecialFunc(KeyControl);
    glutReshapeFunc(ChangeSize);
    glutDisplayFunc(RenderScene);
    InitTexture();
    //이동하는 것을 보려면 glutTimerFunc에 걸린 주석을 풀면 된다. 화살표 키로도 움직이는 것을 볼 수있다.
    glutTimerFunc(33,TimerFunc,1);
    SetupRC();
    glutMainLoop();
    return 0;
}
