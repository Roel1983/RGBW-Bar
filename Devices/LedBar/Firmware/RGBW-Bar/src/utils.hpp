#ifndef _UTILS_HPP_
#define _UTILS_HPP_

template<typename T, uint16_t N>
constexpr uint16_t GetArrLength(T(&)[N]) { return N; }

#endif // _UTILS_HPP_
