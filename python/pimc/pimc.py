import numpy as np
import matplotlib

class PathClass:
    def __init__(self, beads, tau, lam):
        self.lam = lam
        self.beads = beads
        self.NumTimeSlices = len(beads)
        self.NumParticles = len(beads[0])
        print "I have setup the path with a temp of",1.0/(tau*self.NumTimeSlices), "and",self.NumParticles, "particles"

    def SetCouplingConstant(self,c):
        self.c=c

    def SetPotential(self,externalPotentialFunction):
        self.VextHelper=externalPotentialFunction

    def Vee(self,R):
        return 0.0

    def Vext(self,R):
        return self.VextHelper(R)

    def KineticAction(self,slice1,slice2): # you will fill this in
        return tot

    def PotentialAction(self,slice1,slice2): # you will fill this in
        return 0.0

    def RelabelBeads(self):
        slicesToShift=random.randint(0,self.NumTimeSlices-1) l=range(slicesToShift,len(self.beads))+range(0,slicesToShift) self.beads=self.beads[l].copy()

    def KineticEnergy(self): # computes kinetic energy
        return KE/(self.NumTimeSlices+0.0)

    def PotentialEnergy(self): # computes potential energy
        return PE/(self.NumTimeSlices+0.0)

    def Energy(self):
        return self.PotentialEnergy()+self.KineticEnergy()
