

#import <Foundation/Foundation.h>
#import <OpenGL/OpenGL.h>
#import <GLUT/GLUT.h>

//정사각형의 위치와 크기의 초기값 설정
GLfloat x5 = 0.0f;
GLfloat y5 = 0.0f;

GLsizei rsize = 50.0f;

GLfloat xstep = 1.0f;
GLfloat ystep = 1.0f;

// 윈도우 크기 선언
GLfloat window_width;
GLfloat window_height;


void RenderScene(void) {
    
    glClear(GL_COLOR_BUFFER_BIT);
    glColor3f(0.96, 0.76, 0.73);
    glRectf(x5,y5,x5+rsize,y5+rsize);
    //사각형의 생성
    glutSwapBuffers(); //드로잉 실행 후 버퍼 교체
}

void TimerFunction(int value) //callback
{ //x축 범위 (window 안에서 돌아나니도록 설정)
    if(x5 > window_width -rsize || x5 < -window_width)
        xstep = -xstep;
    //y축 범위 (window 안에서 돌아다니도록 설정)
    if(y5> window_height -rsize || y5 < -window_height)
        ystep = -ystep;
    //윈도우가 변경되어 경계를 넘어갔을 때
    if(x5 > window_width-rsize)
        x5 = window_width-rsize -1;
    if(y5 > window_height-rsize)
        y5 = window_height - rsize -1;
    
    x5 += xstep;
    y5 += ystep;
    glutPostRedisplay();
    glutTimerFunc(33, TimerFunction,1);
}

void SetupRC(void) {
    glClearColor(0.67, 0.91, 0.86, 1.0f);
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