/*
 * File : ref_pred.c
 * Abstract:
 *       An example C-file S-function for multiplying an input by 2,
 *       y  = 2*u
 *
 * Real-Time Workshop note:
 *   This file can be used as is (noninlined) with the Real-Time Workshop
 *   C rapid prototyping targets, or it can be inlined using the Target 
 *   Language Compiler technology and used with any target. See 
 *     matlabroot/toolbox/simulink/blocks/tlc_c/timestwo.tlc   
 *     matlabroot/toolbox/simulink/blocks/tlc_ada/timestwo.tlc 
 *   the C and Ada TLC code to inline the S-function.
 *
 * See simulink/src/sfuntmpl_doc.c
 *
 * Copyright 1990-2004 The MathWorks, Inc.
 * $Revision: 1.12.4.2 $
 */


#define S_FUNCTION_NAME  ref_pred
#define S_FUNCTION_LEVEL 2

#include "simstruc.h"

//#define U(element) (*uPtrs[element])  /* Pointer to Input Port0 */

#include "simstruc.h"
#include "tmwtypes.h"
#include <dos.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <conio.h>
#include <math.h>
#include <malloc.h>

/******* Variaveis Definidas *******/
#define NPARAMS 4
#define PARAM_ARG1 ssGetSFcnParam(S,0) 
#define PARAM_ARG2 ssGetSFcnParam(S,1) 
#define PARAM_ARG3 ssGetSFcnParam(S,2)
#define PARAM_ARG4 ssGetSFcnParam(S,3)


#define Ts   0.06  // Periodo de amostragem utilizado pela funcao
#define PI   3.141592 
unsigned int XI;
unsigned int YI;
unsigned int XF;
unsigned int YF;

float TrajX[10000];				//vetor contendo a trajet�ria em X
float TrajY[10000];				//vetor contendo a trajet�ria em Y
float TrajTheta[10000];
int Index;
int TrajPoints;
int TrajOK;
double v_ref;
double vn_ref;
double w_ref;

// double FMod(double x, double d){
//   return frac(x/d)*d;
// }


double Rad(double xw){
  return xw*(PI/180);
}

double Deg(double xw){
  return xw*(180/PI);
}

double Dist(double x, double y) {
  return sqrt(x*x+y*y);
}


double DiffAngle(double a1, double a2){

    double result;

    result = a1-a2;
    if (result<0) result = -fmod(-result,2*PI);
    if (result<-PI) result = result+2*PI;
        else result = fmod(result,2*PI);
    if (result>PI) result = result-2*PI;
    
    return result;
}

double Distpoint2line(double x1, double y1, double x2, double y2, double x3, double y3) {
    
 double teta;
 double alfa;
 double yp1;
 double d1_3;
 
  // angulo da recta no mundo
  teta = atan2(y2-y1,x2-x1);

  // angulo entre a recta e o vector que une o ponto (x1,y1) ao ponto (x3,y3)
  alfa = atan2(y3-y1,x3-x1)-teta;

  d1_3 = Dist(x3-x1,y3-y1);

  // distancia do ponto (x3,y3) para a linha que passa pelos pontos (x1,y1) e (x2,y2)
  yp1 = d1_3*sin(alfa);

  return yp1;
   
}


void TranslateAndRotate(double* rx, double* ry, double px, double py, double tx, double ty, double teta) {
double vx,vy,a;

// Translacao do vector (px,py) segundo o vector (tx,ty)
// seguida de Rotacao do angulo teta

  vx = px+tx;
  vy = py+ty;
  *rx = vx*cos(teta)-vy*sin(teta);
  *ry = vx*sin(teta)+vy*cos(teta);
}


void TrajectoryControl(double x, double y, double teta){
    
double ang;

 ang = fabs(DiffAngle(atan2(y-TrajY[Index+1],x-TrajX[Index+1]),atan2(TrajY[Index+1]-TrajY[Index],TrajX[Index+1]-TrajX[Index])));      
  
 if (ang < PI/2){
  
   if (Index == TrajPoints-1){
       TrajOK=1;
   }else{
       Index++;
   }
 
    if (Index == TrajPoints-2){
      if (Dist(x-TrajX[TrajPoints-1],y-TrajY[TrajPoints-1]) < 0.02)
      TrajOK=1;
    }
 };
 
// printf("Index: %d %d \n", Index,TrajOK );
 
};

     
void PointController(double *v, double *vn, double *w, double x, double y, double teta, double vref, int i) {

  double vx_traj,vy_traj,ang,erroToPoint,angp,d1,d,alfa,teta_ref,xaux,yaux,tetaDif,rtx,rty,vx,vy,va,vky,vtraj,ey,ex,eteta,aux;
  
   
  vx_traj = (TrajX[Index+1+i] - x); ///Ts;
  vy_traj = (TrajY[Index+1+i] - y); ///Ts;
  //vtraj = sqrt(vx_traj*vx_traj+vy_traj*vy_traj); //vtraj
  ang = atan2(vy_traj,vx_traj);
  
  vtraj=vref;
  vx = vtraj*cos(ang);
  vy = vtraj*sin(ang);
  
  *v = vx*cos(teta) + vy*sin(teta);
  *vn = vy*cos(teta) - vx*sin(teta);
 //  printf ("v: %lf \n",  *v);
 //  printf ("vn: %lf \n",  *vn);
  
   eteta = TrajTheta[Index+1+i] - teta;
  // printf ("erroTheta: %lf \n", eteta);
   if (fabs(eteta) < Rad(0.01)) eteta = 0;
   *w = 1*eteta; // 1 = ganho k2 controlador
     
    
}


/*================*
 * Build checking *
 *================*/


/* Function: mdlInitializeSizes ===============================================
 * Abstract:
 *   Setup sizes of the various vectors.
 */
static void mdlInitializeSizes(SimStruct *S)
{
    ssSetNumSFcnParams(S, NPARAMS);
    if (ssGetNumSFcnParams(S) != ssGetSFcnParamsCount(S)) {
        return; /* Parameter mismatch will be reported by Simulink */
    }

    if (!ssSetNumInputPorts(S, 1)) return;
    ssSetInputPortWidth(S, 0, 5); //DYNAMICALLY_SIZED
    ssSetInputPortDirectFeedThrough(S, 0, 1);

    if (!ssSetNumOutputPorts(S,1)) return;
    ssSetOutputPortWidth(S, 0, 15); // Tamanho da porta de saida 0 a 23 (24)

    ssSetNumSampleTimes(S, 1);

    /* Take care when specifying exception free code - see sfuntmpl_doc.c */
    ssSetOptions(S,
                 SS_OPTION_WORKS_WITH_CODE_REUSE |
                 SS_OPTION_EXCEPTION_FREE_CODE |
                 SS_OPTION_USE_TLC_WITH_ACCELERATOR);
}


/* Function: mdlInitializeSampleTimes =========================================
 * Abstract:
 *    Specifiy that we inherit our sample time from the driving block.
 */
static void mdlInitializeSampleTimes(SimStruct *S)
{
    ssSetSampleTime(S, 0, INHERITED_SAMPLE_TIME);
    ssSetOffsetTime(S, 0, 0.0);
    ssSetModelReferenceSampleTimeDefaultInheritance(S); 
    v_ref=0;
    vn_ref=0;
    w_ref=0;
 }



#define MDL_START  /* Change to #undef to remove function */
#if defined(MDL_START) 
  /* Function: mdlStart =======================================================
   * Abstract:
   *    This function is called once at start of model execution. If you
   *    have states that should be initialized once, this is the place
   *    to do it.
   */
  static void mdlStart(SimStruct *S)
  {
  
  
  real_T      *par1 = mxGetPr(PARAM_ARG1); // vetor com X
  real_T      *par2 = mxGetPr(PARAM_ARG2); // vetor com Y 
  real_T      *par3 = mxGetPr(PARAM_ARG3); // vetor com theta 
  real_T      *par4 = mxGetPr(PARAM_ARG4); // numero de pontos da trajetoria
  int i;
	
  TrajPoints = (int) *par4;
  
  for (i = 0; i < TrajPoints; i++){

      TrajX[i]=par1[i];
      TrajY[i]=par2[i];
      TrajTheta[i]=par3[i];
  }

  Index=0;
  TrajOK=0;
      
  
  }
#endif /*  MDL_START */







/* Function: mdlOutputs =======================================================
 * Abstract:
 *    y = 2*u
 */
static void mdlOutputs(SimStruct *S, int_T tid)
{
    int_T             i;
    InputRealPtrsType uPtrs = ssGetInputPortRealSignalPtrs(S,0);
    real_T            *y    = ssGetOutputPortRealSignal(S,0);
    int_T             width = ssGetOutputPortWidth(S,0);
    double xrobo, yrobo, tetarobo, vref;
    float a,b;
    int N,j;
    
    xrobo=*uPtrs[0];
    yrobo=*uPtrs[1];
    tetarobo=*uPtrs[2];
    vref=*uPtrs[3];
    N=*uPtrs[4];  
   
    if (TrajOK==1) {
        y[0] = 0; 
        y[1] = 0;
        y[2] = 0;      
    }else {

        TrajectoryControl(xrobo, yrobo, tetarobo);
   
        for(j=0;j<N;j++) {
        
            if(Index+j < TrajPoints-1) {
                PointController(&v_ref, &vn_ref, &w_ref, xrobo, yrobo, tetarobo, vref, j);
            }
            else {
        
                v_ref = 0;
                vn_ref = 0;
                w_ref = 0;
            }
            
            y[3*j] = v_ref; 
            y[3*j+1] = vn_ref;
            y[3*j+2] = w_ref;  
    
        }
       
    };
    
}


/* Function: mdlTerminate =====================================================
 * Abstract:
 *    No termination needed, but we are required to have this routine.
 */
static void mdlTerminate(SimStruct *S)
{
}



#ifdef  MATLAB_MEX_FILE    /* Is this file being compiled as a MEX-file? */
#include "simulink.c"      /* MEX-file interface mechanism */
#else
#include "cg_sfun.h"       /* Code generation registration function */
#endif
