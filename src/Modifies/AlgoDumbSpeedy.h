// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.

#ifndef MODIFIES_DUMBSPEEDY_H
#define MODIFIES_DUMBSPEEDY_H

#include <algorithm>
#include <iterator>

#include "Modifies.h"
#include "../Callgraph/Callgraph.h"
#include "../PointsTo/PointsTo.h"

namespace llvm { namespace mods {

    struct DUMB_SPEEDY {};

}}

namespace llvm {

    template<>
    struct AlgorithmProperties<mods::DUMB_SPEEDY>
    {
        typedef AnalysisProperties<true,true,false,false,false,false>
                Type;
    };

}

namespace llvm { namespace mods {

  template<typename Language, typename PointsToSets>
  void computeModifies(typename ProgramStructure<Language,
        typename llvm::AlgorithmProperties<DUMB_SPEEDY>::Type >::Type const& P,
        typename llvm::callgraph::Callgraph<Language>::Type const& CG,
        PointsToSets const& PS,
        typename Modifies<Language,DUMB_SPEEDY>::Type& MOD, DUMB_SPEEDY) {
    typedef typename ProgramStructure<Language,
                typename llvm::AlgorithmProperties<DUMB_SPEEDY>::Type>::Type
            Program;

    for (typename Program::const_iterator f = P.begin(); f != P.end(); ++f)
      for (typename Program::mapped_type::const_iterator c = f->second.begin();
           c != f->second.end(); ++c)
        if (c->getType() == CMD_VAR) {
          if (!P.isLocalToFunction(c->getVar(),f->first))
              MOD[f->first].insert(c->getVar());
        } else if (c->getType() == CMD_DREF_VAR) {
          typename PointsToSets::PointsToSet const& S =
              llvm::ptr::getPointsToSet(c->getVar(),PS);
          for (typename PointsToSets::PointsToSet::const_iterator p = S.begin();
               p != S.end(); ++p)
            if (!P.isLocalToFunction(*p,f->first) && !P.isConstantValue(*p))
              MOD[f->first].insert(*p);
        }

    typedef typename llvm::callgraph::Callgraph<Language>::Type Callgraph;
    for (typename Callgraph::const_iterator i = CG.begin_closure();
          i != CG.end_closure(); ++i) {
      typename Modifies<Language,DUMB_SPEEDY>::Type::mapped_type const&
          src = MOD[i->second];
      typedef typename Modifies<Language,DUMB_SPEEDY>::Type::mapped_type dst_t;
      dst_t &dst = MOD[i->first];

      std::copy(src.begin(), src.end(), std::inserter(dst, dst.end()));
#if 0 /* original boost+STL uncompilable crap */
      using std::tr1::bind;
      using std::tr1::placeholders::_1;
      using std::tr1::cref;
      dst.erase(std::remove_if(dst.begin(), dst.end(),
                bind(&Program::isLocalToFunction, cref(P), _1, i->first)),
                dst.end());
#endif
      for (typename dst_t::iterator I = dst.begin(), E = dst.end(); I != E; ) {
        if (P.isLocalToFunction(*I, i->first))
          dst.erase(I++);
        else
          ++I;
      }
    }
  }

}}

#endif