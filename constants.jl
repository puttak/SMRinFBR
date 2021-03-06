################################################################################
#                                   Constants                                  #
################################################################################
const global Comp    = ["CH4", "CO", "CO2", "H2", "H2O", "N2"] # Component names

const global Nz      = 20          # Number of collocation points in z direction
const global Ncomp   = 6                         # Number of chemical components
const global Nr      = 10               # Number of radial discretization points
const global Nglob   = Nz*Nr                         # Global collocation points

const global CompIndex = [6, 5, 3, 4, 1]    # Indices of components to be solved
const revertIndex      = [5, 6, 3, 4, 2, 1]    # Indices for reverting wVec to w


################################################################################
#                      Collocation parameters for z                            #
################################################################################
const global Length  = 7                                 # Length of reactor [m]
dummyZ,dummyA,dummyB,dummyQ = colloc(Nz-2,1,1) # Collocation points and matrices
const global Z = Length*dummyZ                       # Scaling of reactor length
const global LagAz = 1/Length*dummyA             # Scale axial derivative matrix
const global LagBz = 1/Length^2*dummyB    # Scale axial second derivative matrix
const global Lagz = eye(Nz)                         # Identity matrix of size Nz

################################################################################
#                      Collocation parameters for r                            #
################################################################################
const global Radius  = 0.102/2                            # Radiu of reactor [m]
dummyR,dummyA,dummyB,dummyQ = colloc(Nr-2,1,1) # Collocation points and matrices
const global r = Radius*dummyR                            # Scale reactor radius
const global LagAr = 1/Radius*dummyA            # Scale radial derivative matrix
const global LagBr = 1/Radius^2*dummyB   # Scale radial second derivative matrix
const global Lagr = eye(Nr)                         # Identity matrix of size Nz

################################################################################
#                              Reactor parameters                              #
################################################################################
const global R          = 8.3145             # Gas constant   [J K^{-1}mol^{-1}]
const global void       = 0.528                                  # Void fraction
const global efficiency = 1e-3          # Efficiency factor for pellet diffusion
const global dInner     = 2*Radius                     # Inner tube diameter [m]
const global Ta         = 1100.0                       # Ambient temperature [K]
const global rhoCat     = 2355.2;                 # Catalyst density [kg m^{-3}]
const global dParticle  = 0.0173;                        # Particle diameter [m]
const global lambdaSt   = 52         # Heat coef. for tube metal[W m^{-1}K^{-1}]
const global rInner     = dInner/2                       # Inner tube radius [m]
const global rOuter     = 0.066                          # Outer tube radius [m]

################################################################################
#                              Molar masses                                    #
################################################################################
const global molarMass = [
                            16.04                                          # CH4
                            28.01                                           # CO
                            44.01                                          # CO2
                            2.02                                            # H2
                            18.02                                          # H2O
                            28.01                                           # N2
                          ]*1e-3                                 # [kg mol^{-1}]

################################################################################
#                              Reaction rate data                              #
################################################################################
# Preexponential factors for the rate constants           [mol kgcat^{-1}s^{-1}]
const global aj = [
                    4.255e15                                        # Reaction 1
                    1.955e6                                         # Reaction 2
                    1.020E15                                        # Reaction 3
                  ]/3.6

# Preexponential factors for the adsorbtion constants
const global ax = [
                    6.65e-9                             # Factor for CH4 [Pa^-1]
                    8.23e-10                             # Factor for CO [Pa^-1]
                    6.12e-14                             # Factor for H2 [Pa^-1]
                    1.77e5                                  # Factor for H2O [-]
                  ]


# Activation energies for the reactions                             [J mol^{-1}]
const global actEn = [
                        240.1e3                    # Activation energy for rx. 1
                        67.13e3                    # Activation energy for rx. 2
                        243.9e3                    # Activation energy for rx. 3
                     ]
# Stoichiometric matrix
const global N = [-1     1   0   3   -1   0                               # rx 1
                   0    -1   1   1   -1   0                               # rx 2
                  -1     0   1   4   -2   0];                             # rx 3

################################################################################
#                              Enthalpy data                                   #
################################################################################
# Reaction enthalpies at 298K                                       [J mol^{-1}]
const global ent298 = [
                        206.1e3                             # Enthalpy for rx. 1 
                        -41.15e3                            # Enthalpy for rx. 2
                        164.9e3                             # Enthalpy for rx. 3
                      ]

# Reaction enthalpies at 948K                                       [J mol^{-1}]
const global ent948 = [
                        224.0e3                             # Enthalpy for rx. 1 
                        -37.30e3                            # Enthalpy for rx. 2
                        187.5e3                             # Enthalpy for rx. 3
                      ]

# Adsorption enthalpies                                             [J mol^{-1}]
const global adEnt = [
                       -38.28e3                 # Enthalpy of adsorption for CH4
                       -70.65e3                  # Enthalpy of adsorption for CO
                       -82.90e3                  # Enthalpy of adsorption for H2
                       88.68e3                  # Enthalpy of adsorption for H2O
                     ]
################################################################################
#                              Heat capacity data                              #
################################################################################
# Heat capacity coefficients matrix
const global cpCoeff = [
                        1.925e4  5.213e1  1.197e-2 -1.132e-5               # CH4
                        3.087e4 -1.285e1  2.789e-2 -1.272e-5                # CO
                        1.980e4  7.344e1 -5.602e-2  1.715e-5               # CO2
                        2.714e4  9.274e0 -1.381e-2  7.645e-6                # H2
                        3.224e4  1.924e0  1.055e-2  3.596e-6               # H2O
                        3.115e4 -1.357e1  2.268e-2 -1.168e-5                # N2
                        ]'*1e-3

################################################################################
#                              Viscosity data                                  #
################################################################################

const global b = [
                  1.00e-6        # Coefficient for CH4 [kg m^{-1}s^{-1}K^{-0.5}]
                  1.50e-6         # Coefficient for CO [kg m^{-1}s^{-1}K^{-0.5}]
                  1.50e-6        # Coefficient for CO2 [kg m^{-1}s^{-1}K^{-0.5}]
                  0.65e-6         # Coefficient for H2 [kg m^{-1}s^{-1}K^{-0.5}]
                  1.74e-6        # Coefficient for H2O [kg m^{-1}s^{-1}K^{-0.5}]
                  1.40e-6         # Coefficient for N2 [kg m^{-1}s^{-1}K^{-0.5}]
                  ]
const global s = [
                  165                                  # Coefficient for CH4 [K]
                  220                                   # Coefficient for CO [K]
                  220                                  # Coefficient for CO2 [K]
                  67                                    # Coefficient for H2 [K]
                  626                                  # Coefficient for H2O [K]
                  108                                   # Coefficient for N2 [K]
                  ]
################################################################################
#                               Conductivity data                              #
################################################################################
const global lambda = [
                      -1.8690e-03   8.7270e-05   1.1790e-07  -3.6140e-11   # CH4
                       5.0670e-04   9.1025e-05  -3.5240e-08   8.1990e-12    # CO 
                      -7.2150e-03   8.0150e-05   5.4770e-09  -1.0530e-11   # CO2
                       8.0990e-03   6.6890e-04  -4.1580e-07   1.5620e-10    # H2 
                       7.3410e-03  -1.0130e-05   1.8010e-07  -9.1000e-11   # H2O
                       3.9190e-04   9.9660e-05  -5.0670e-08   1.5040e-11    # N2 
                      ]
