

#import <Foundation/Foundation.h>
#import <OpenGL/OpenGL.h>
#import <GLUT/GLUT.h>

void RenderScene(void) {
    
    glClear(GL_COLOR_BUFFER_BIT);
    glColor3f(0.96, 0.76, 0.73);
    glRectf(0.0f, 0.0f, 50.0f, 30.0f);
    glFlush();
}

void SetupRC(void) {
    glClearColor(0.67, 0.91, 0.86, 1.0f);
}

//void KeyControl(int key, int x, int y) {
//    if(key == GLUT_KEY_UP) {
//        xRot -=5.0f;
//    }
//    if(key == GLUT_KEY_DOWN) {
//        xRot +=5.0f;
//    }
//    if(key == GLUT_KEY_LEFT) {
//        yRot -= 5.0f;
//    }
//    if(key == GLUT_KEY_RIGHT) {
//        yRot += 5.0f;
//    }
//    glutPostRedisplay();
//}

void ChangeSize(GLsizei w, GLsizei h)
{
    GLfloat nRange = 100.0f;
    
    glViewport(0, 0, w, h);
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    if(w<=h) {
        glOrtho(-nRange, nRange, -nRange*h/w, nRange*h/w, -nRange, nRange);
    } else {
        glOrtho(-nRange*w/h, nRange*w/h, -nRange, nRange, -nRange, nRange);
    }
    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
}

int main(int argc,char * argv[])
{
    glutInit(&argc,argv);
    glutInitDisplayMode(GLUT_SINGLE | GLUT_RGB);
    glutInitWindowPosition(0, 0);
    glutInitWindowSize(512, 512);
    glutCreateWindow("Rectangle");
   //    glutSpecialFunc(KeyControl);
    glutDisplayFunc(RenderScene);
    glutReshapeFunc(ChangeSize);

    SetupRC();
    glutMainLoop();
    return 0;
}