/*
Raul P. Pelaez 2016. MD simulator using Interactor and Integrator, example of usage.

NOTES:
The idea is to mix implementations of Integrator and Interactor to construct a simulation. 
For example create a TwoStepVelVerlet integrator and add a PairForces interactor with LJ to create a lennard jonnes gas MD simulation.


Once initialized this classes will perform a single task very fast as black boxes:

Integrator uploads the positions according to the velocities, forces and current positions.
Interactor computes the pair forces using the current positions according to the selected potential

The idea is for Integrator to control the positions and velocities and for Interactor to control the forces. Communicating each variable when needed. So if you need the vel. in the force computing you can pass it to your implementation of Interactor and use it in the force function accordingly.

The float4 forces contains fx, fy, fz, E. 
The float4 pos contains x,y,z,type

Several interactors can be added to an integrator, for example one interactor for pair forces, another for bonded forces..


TODO:
100- The force array should not be handled by the user
*/
#ifndef DRIVER_H
#define DRIVER_H
#include"Interactor/Interactor.h"
#include"Interactor/PairForces.h"
#include"Integrator/Integrator.h"
#include"Integrator/TwoStepVelVerlet.h"
#include"Integrator/BrownianEulerMaruyama.h"
#include"utils/utils.h"
#include<memory>

class Driver{
//Integrator and Interactor take care of the
// updating of positions and computing the pair forces. You can do anything in between.
  shared_ptr<Interactor> interactor;
  shared_ptr<Integrator> integrator;

  uint N;
//You are supposed to be in charge of the positions and forces, and initialize them before giving them to Integrator and Interactor.
Vector<float4> pos, force;
public:
  //The constructor configures and initializes the simulation
  Driver(uint N, float L, float rcut, float dt);
  //Move 1 dt forward in time
  void update();

  //Write the current positions to disk, concurrently if block is false or not given
  void write(bool block = false);
  //Read an initial configuratio nfrom fileName, TODO
  void read(const char *fileName);

};

#endif
