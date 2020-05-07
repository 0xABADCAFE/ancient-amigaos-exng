TARGET   = compander
CXXFLAGS = -Wall -O2
LCINCS   = -I../../include
LIBDIR   = -L../../libsrc/plat/linux_i386/lib/
LLDLIBS  = -lsystemlib

OBJS = app.o compander.o

$(TARGET): $(OBJS) Makefile
	$(CXX) $(CXXFLAGS) -o $@ $(OBJS) $(LIBDIR) $(LLDLIBS)

app.o: app.cpp
	$(CXX) $(CXXFLAGS) $(LCINCS) ${LCLIBS} -o $@ -c $<

compander.o: compander.cpp
	$(CXX) $(CXXFLAGS) $(LCINCS) ${LCLIBS} -o $@ -c $<
	
clean:
	/bin/rm -f $(TARGET) *.o *~ core
