int shapeNr= 0;
// Saving nice shapes in arrays
// {m1, n1a, n1b, n1c, m2, n2a, n2b, n2c, a1, b1, a2, b2}
float [] [] shape = {
  { 1, 1, 1,1,1, 1, 1,1,1,1,1.9,1.9},
 { 5.7, 26, -18,0.6 ,20, 1, 0.62,1.25,0.34,0.34,2.4,2.3}, 
 { 2, 10, 2.5 ,5,8, 1, 6,5,0.68,0.68,1,1},
 { 2, 2.5, 1 ,13,20, 1, 1,12,0.68,1.4,1.5,1},
 { 20, 2.5, 1,13,20, 1, 1,13,2,1,1,1},
 
};

boolean shift=false;

//automomous changing shape shiftin
void animshapeShift(){
 
 if(frameCount%5000==0) {
   shapeShift(shapeNr) ;
   
   if(shapeNr<shape.length-1) shapeNr++;
   else shapeNr=0;
   
//   println(shapeNr);
 }
  
}


void shapeShift(int x){
 
  int shap=x;
  
  m1S=shape[shap][0];
  n1aS=shape[shap][1];
  n1bS=shape[shap][2];
  n1cS=shape[shap][3];
  
  m2S=shape[shap][4];
  n2aS=shape[shap][5];
  n2bS=shape[shap][6];
  n2cS=shape[shap][7];
  
  a1S=shape[shap][8];
  b1S=shape[shap][9];
  a2S=shape[shap][10];
  b2S=shape[shap][11];
}