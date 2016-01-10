
//
//  main.m
//  openGL
//
//  Created by 정민 황 on 2015. 12. 14..
//  Copyright © 2015년 정민 황. All rights reserved.
//

//gl, glu, glut 3개의 접두어.

//더블 버퍼링
//하나는 화면을 그리고,
//나머지 버퍼는 화면을 할당.
// 다 그리면 스왑.

#import <Foundation/Foundation.h>
#import <OpenGL/OpenGL.h>
#import <GLUT/GLUT.h>
#import <math.h>

#define GL_PI 3.1415f
static GLfloat xRot = 0.0f;
static GLfloat yRot = 0.0f;

void SetupRC() {
    glClearColor(0.0f, 0.0f, 0.0f, 1.0f);
    glColor3f(0.0f,1.0f,0.0f);
}

void RenderScene(void) {
    GLfloat x,y,z,angle;
    glClear(GL_COLOR_BUFFER_BIT);
    
    glPushMatrix();
    glRotatef(xRot,1.0f,0.0f,0.0f);
    glRotatef(yRot,0.0f,1.0f,0.0f);
    glBegin(GL_LINES);
    z = -50.0f;
    
    for( angle = 0.0f; angle <= (2.0f*GL_PI)*3.0f; angle += 0.1f)
        // 3.14/0.1 개의 포인트를 뿌린다 총 3바퀴
    {
        x = 60.0f*sin(angle);
        y = 60.0f*cos(angle);
        glVertex3f(x,y,z);
        z += 0.5f;
    }
    glEnd();
    glPopMatrix();
    glutSwapBuffers();
}

void KeyControl(int key, int x, int y) {
    if(key == GLUT_KEY_UP) {
        xRot -=5.0f;
    }
    if(key == GLUT_KEY_DOWN) {
        xRot +=5.0f;
    }
    if(key == GLUT_KEY_LEFT) {
        yRot -= 5.0f;
    }
    if(key == GLUT_KEY_RIGHT) {
        yRot += 5.0f;
    }
    glutPostRedisplay();
}

void ChangeSize(int w, int h)
{
    GLfloat nRange = 100.0f;
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    glViewport(0, 0, w, h);
    
    if(w<=h) {
        glOrtho(-nRange, nRange, -nRange*h/w, nRange*h/w, -nRange, nRange);
    } else {
        glOrtho(-nRange*w/h, nRange*w/h, -nRange, nRange, -nRange, nRange);
    }
    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
}

int main(int argc, const char * argv[])
{
    glutInit(&argc,argv);
    glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB | GLUT_DEPTH);
    glutInitWindowPosition(0, 0);
    glutInitWindowSize(512, 512);
    glutCreateWindow("spring");
    glutReshapeFunc(ChangeSize);
    glutSpecialFunc(KeyControl);
    glutDisplayFunc(RenderScene);
    SetupRC();
    glutMainLoop();
    return 0;
}

//
//
//void RenderScene(void)
//{
//    glClear(GL_COLOR_BUFFER_BIT);
//    glFlush();
//}
//void SetupRC(void)`
//{
//    glClearColor(0.0f, 0.0f,1.0f,1.0f);
//}
//int main(int argc, const char * argv[])
//    {
//        glutInit(&argc,argv);
//        glutInitDisplayMode(GLUT_SINGLE | GLUT_RGB);
//        glutCreateWindow("Simple");
//        glutDisplayFunc(RenderScene);
//        SetupRC();
//        glutMainLoop();
//        return 0;
//    }