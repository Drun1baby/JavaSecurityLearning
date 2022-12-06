/*! \file JmsTypes.h
    \brief Describes platform specific defines
    
    This file is used to mitigate platform dependencies.  This file
    is the one used for Windows, and will vary from platform
    to platform
    \author Copyright (c) 2002, BEA Systems, Inc.
*/

#ifndef _JMS_TYPES_H
#define _JMS_TYPES_H 1

/*!
  A 32-bit signed entity
  */
#define JMS32I int
/*!
  A 64-bit signed entity
  */
#define JMS64I __int64
/*!
  The calling convention to use (on most platforms not defined)
  */
#define JMSENTRY __stdcall

#endif /* _JMS_TYPES_H */

