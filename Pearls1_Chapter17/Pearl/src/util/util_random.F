      double precision function util_random(iseed)
      implicit none
#include "errquit.fh"
c $Id: util_random.F 26140 2014-09-03 00:19:44Z edo $
c
c routine to give a random number [0,1]
c
c     iseed is an integer seed when non-zero used to initialize the sequence     
c
#if defined(IBM) || defined(SP1) || ( defined(BGQ) && !defined(GFORTRAN) )
      integer iseed
      if(iseed.gt.0) call srand(dble(iseed))
      util_random=rand()
#elif defined(KSR)
      real random
      external random
      integer iseed
* on KSR if iseed != 0 it resets the sequence
      util_random=dble/work/u13377/nwchem(random(iseed))
#elif defined(SGI) || defined(SGITFP)
       integer iseed
       real*8 rand
       external rand
       if(iseed.gt.0) call srand(dble(iseed))
       util_random=rand()
#elif defined(CRAY)
      integer iseed
      if(iseed.gt.0) call ranset(iseed)
      util_random=ranf()
#elif defined(WIN32) &&!defined(__MINGW32__)
      integer iseed
      double precision drand
      external drand
      if (iseed.gt.0) call srand(iseed)
      util_random = drand(0)
#elif (defined(LINUX) || defined(CYGNUS)) && !defined(LINUXALPHA)
      integer iseed
      double precision linux_rand
      external linux_rand
      if(iseed.gt.0) call linux_sran(iseed)
      util_random=linux_rand()
#else
      integer iseed
      double precision drand
      external drand
      util_random = drand(iseed)
#endif
      end


