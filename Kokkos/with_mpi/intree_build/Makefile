KOKKOS_PATH = ../../../kokkos-3.6.00
EXE_NAME = "kokkos_example"

SRC = $(wildcard *.cpp)

default: build
	echo "Start Build"

CXX = CC
EXE = ${EXE_NAME}
KOKKOS_ARCH = "BDW"
KOKKOS_DEVICES = "OpenMP"
CXXFLAGS = -O3
LINKFLAGS =

LINK = ${CXX}

DEPFLAGS = -M

OBJ = $(SRC:.cpp=.o)
LIB =

include $(KOKKOS_PATH)/Makefile.kokkos

build: $(EXE)

$(EXE): $(OBJ) $(KOKKOS_LINK_DEPENDS)
	$(LINK) $(KOKKOS_LDFLAGS) $(LINKFLAGS) $(EXTRA_PATH) $(OBJ) $(KOKKOS_LIBS) $(LIB) -o $(EXE)

clean: kokkos-clean
	rm -f *.o *.cuda *.host

# Compilation rules

%.o:%.cpp $(KOKKOS_CPP_DEPENDS)
	$(CXX) $(KOKKOS_CPPFLAGS) $(KOKKOS_CXXFLAGS) $(CXXFLAGS) $(EXTRA_INC) -c $<

test: $(EXE)
	./$(EXE)
