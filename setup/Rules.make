#---------------------------------------------------------------------
# PyMOL Makefile Rules 
#---------------------------------------------------------------------
#
#- Building ----------------------------------------------------------
#--- Tell "make" how to get to PyMOL 
PYMOL_PATH = /users/warren/pymol
#---------------------------------------------------------------------
#
#- Dependencies ------------------------------------------------------
#--- X-windows
XLIB_DIR = -L/usr/X11R6/lib
XINC_DIR = -I/usr/X11R6/include
#--- Python
PYTHON_EXE = $(PYMOL_PATH)/ext/bin/python
PYTHON_LIB =
PYTHON_LIB_DIR = 
PYTHON_INC_DIR = -I$(PYMOL_PATH)/ext/include/python2.2 \
	-I$(PYMOL_PATH)/ext/include/python2.2/Numeric
#--- Other external dependencies
EXT_INC_DIR = -I$(PYMOL_PATH)/ext/include
EXT_LIB_DIR = -L$(PYMOL_PATH)/ext/lib
#---------------------------------------------------------------------
#
#- Build for LINUX as an importable module ---------------------------
#--- System libraries
LIBS = $(PYTHON_LIB) -lglut -lGL -lGLU -lpng -lXmu $(ZLIB) -lm
#--- PyMOL configuration
DEFS = -D_PYMOL_MODULE -D_PYMOL_NUMPY 
#--- How we build shared libraries
BUILD = -shared 
#--- What are we trying to build?
DEST = -o modules/pymol/_cmd.so
#--- Gcc Options for Linux
CCOPT1 = -march=i486 -D__i686__ -ffast-math -Wall -ansi -Wmissing-prototypes
#--- libraries for PyOpenGL 
PYOGL_LIB =  -lglut -lGL -lGLU -lXmu -lXi
#---------------------------------------------------------------------
#
#- Choose One --------------------------------------------------------
#--- GCC Optimized
CCOPT2 = -O3 -funroll-loops -fomit-frame-pointer
#--- GCC Profiling
#CCOPT2 = -pg -O3 -funroll-loops
#--- Debugging
#CCOPT2 = -g
#---------------------------------------------------------------------
#
#- Choose One --------------------------------------------------------
#--- Workaround for very old XFree86/DRI linux dll problem
BUGS = -D_DRI_WORKAROUND
#---
#BUGS =
#---------------------------------------------------------------------
#
#- Choose One Pair ---------------------------------------------------
#--- Libpng2 available and contains zlib 
#PNG = -D_HAVE_LIBPNG 
#ZLIB = 
#--- Libpng2 available but needs zlib 
PNG = -D_HAVE_LIBPNG 
ZLIB = -lz
#--- Libpng2 not available
#PNG = 
#ZLIB = 
#---------------------------------------------------------------------
#
#---------------------------------------------------------------------
# No changes normally required below here
#---------------------------------------------------------------------

CC = cc

LIB_DIRS = $(EXT_LIB_DIR) $(PYTHON_LIB_DIR) $(XLIB_DIR)

# Enable source files to find headers
PYMOL_INC_DIRS = -I../layer0 -I../layer1 -I../layer2 \
   -I../layer3 -I../layer4 -I../layer5 

C_FLAGS = $(CCOPT1) $(CCOPT2) $(EXT_INC_DIR) $(PYTHON_INC_DIR) \
   $(XINC_DIR) $(PNG) $(DEFS) $(BUGS)

CFLAGS = $(C_FLAGS)














