KOKKOS_PATH = ../../../kokkos-4.1.00
KOKKOS_DEVICES = "OpenMP,Serial" # replaced by passing options to make
KOKKOS_ARCH = "ZEN3" # replaced by passing options to make
EXE_NAME = "kokkos_example"

SRC = $(wildcard *.cpp)

default: build
	echo "Start Build"


CXX = CC 
EXE = ${EXE_NAME}

LINK = ${CXX}
LINKFLAGS =

DEPFLAGS = -M

OBJ = $(SRC:.cpp=.o)
LIB =

build: $(EXE)

include $(KOKKOS_PATH)/Makefile.kokkos


$(EXE): $(OBJ) $(KOKKOS_LINK_DEPENDS)
	$(LINK) $(KOKKOS_LDFLAGS) $(LINKFLAGS) $(EXTRA_PATH) $(OBJ) $(KOKKOS_LIBS) $(LIB) -o $(EXE)

clean: kokkos-clean
	rm -f *.o *.cuda *.host

# Compilation rules

%.o:%.cpp $(KOKKOS_CPP_DEPENDS)
	$(CXX) $(KOKKOS_CPPFLAGS) $(KOKKOS_CXXFLAGS) $(CXXFLAGS) $(EXTRA_INC) -c $<

test: $(EXE)
	./$(EXE)
