/*Raul P. Pelaez 2018-2020. Some utilities for working with Potentials.


 */
#ifndef POTENTIALUTILS_CUH
#define POTENTIALUTILS_CUH

#include"utils/cxx_utils.h"
#include"utils/TransverserUtils.cuh"
namespace uammd{
  namespace Potential{
    //This macro defines a struct called has_getEnergyTransverser
    SFINAE_DEFINE_HAS_MEMBER(getEnergyTransverser)
    //Calling get on this struct will provide the getEnergyTransverser of a Potential if it exists, and will return a BasicNullTransverser otherwise
    template<class T, bool hasEnergyTransverser = has_getEnergyTransverser<T>::value>
    struct getIfHasEnergyTransverser;

    template<class T>
    struct getIfHasEnergyTransverser<T, true>{
      template<class ...Types>
      static auto get(std::shared_ptr<T> t, Types... args) -> decltype(t->getEnergyTransverser(args...)){
	return t->getEnergyTransverser(args...);
      }
    };

    template<class T>
    struct getIfHasEnergyTransverser<T, false>{
      template<class ...Types>
      static BasicNullTransverser get(std::shared_ptr<T> t, Types... args){
	return BasicNullTransverser();
      }

    };

    //This macro defines a struct called has_getForceEnergyTransverser
    SFINAE_DEFINE_HAS_MEMBER(getForceEnergyTransverser)
    //Calling get on this struct will provide the getForceEnergyTransverser of a Potential if it exists, and will return a BasicNullTransverser otherwise
    template<class T, bool hasForceEnergyTransverser = has_getForceEnergyTransverser<T>::value>
    struct getIfHasForceEnergyTransverser;

    template<class T>
    struct getIfHasForceEnergyTransverser<T, true>{
      template<class ...Types>
      static auto get(std::shared_ptr<T> t, Types... args) -> decltype(t->getForceEnergyTransverser(args...)){
	return t->getForceEnergyTransverser(args...);
      }
    };

    template<class T>
    struct getIfHasForceEnergyTransverser<T, false>{
      template<class ...Types>
      static BasicNullTransverser get(std::shared_ptr<T> t, Types... args){
	return BasicNullTransverser();
      }

    };

  }
}

#endif
