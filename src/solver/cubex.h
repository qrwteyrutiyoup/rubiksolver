/*
 * cubex.h
 * Cubex by Eric Dietz (c) 2003
 * Cube Puzzle and Universal Solver.
 * Notes: readme.txt  Email: root@wrongway.org
 * NOTE: This program is unaffiliated with the Rubik's Cube Trademark.
 * This program MAY NOT be reproduced or modified outside the licensing terms
 * set forth in the readme.
 */

#ifndef _CUBEX_H_
#define _CUBEX_H_

// required includes/namespace
#include <string>
using namespace std;

// Class declaration - class members/methods, some encapsulated
class Cubex
{
public:
  Cubex();
  virtual ~Cubex();
  static int numcubes;
  const static char* ver;
  const static char* author;
  const static int N = 3; // <-- size of the cube (NxNxN)
  const static int MOV = 8;
  bool operator==(const Cubex &q);
  bool operator!=(const Cubex &q);
  int *face(int x, int y, int z);
  void RenderScreen();
  bool IsSolved();
  void ResetCube();
  bool XML(int a, bool n);
  bool XMR(int a, bool n);
  bool XMU(int a, bool n);
  bool XMD(int a, bool n);
  bool XMC(int a, bool n);
  bool XMA(int a, bool n);
  void UL();
  void UR();
  void DL();
  void DR();
  void LU();
  void LD();
  void RU();
  void RD();
  void FC();
  void FA();
  void BC();
  void BA();
  void ML();
  void MR();
  void MU();
  void MD();
  void MC();
  void MA();
  void CL();
  void CR();
  void CU();
  void CD();
  void CC();
  void CA();
  void XCL();
  void XCR();
  void XCU();
  void XCD();
  void XCC();
  void XCA();
  void ScrambleCube();
  void DoSolution();
  int SolveCube();
  int Cub[N+2][N+2][N+2];
  bool shorten;
  bool cubeinit;
  int cenfix;
  int mov[MOV+1];
  int erval;
  string solution;
  int FindCent(int a);
  int FindEdge(int a, int b);
  int FindCorn(int a, int b, int c);
  const string Concise(string a);
  const string Efficient(string a);
  int fx;
  int fy;
  int fz;
protected:
private:
  void Ctemp();
  const string TopEdges();
  const string TopCorners();
  const string MiddleEdges();
  const string BottomEdgesOrient();
  const string BottomEdgesPosition();
  const string BottomCornersPosition();
  const string BottomCornersOrient();
  const string CentersRotate();
  int Tmp[N+2][N+2][N+2];
};
// end of header

#endif /* _CUBEX_H_ */

// many of the routines have been generalized for NxNxN, with a few exceptions,
// mainly to accomadate the CentersRotate feature.
