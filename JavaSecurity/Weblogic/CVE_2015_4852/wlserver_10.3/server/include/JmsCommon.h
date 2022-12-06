/*! \file JmsCommon.h
    \brief Describes structures used by most of the JMS C API
    \author Copyright (c) 2002, BEA Systems, Inc.
    Describes structures used by most of the JMS C API
*/

#ifndef _JMSCOMMON_H
#define _JMSCOMMON_H 1

#include <JmsTypes.h>

/*!
  This flag is set if a callback function is being called from the JMS C API.  This
  flag is useful if the callback function might also be called from the application
  code.
  */
#define JMS_CALLED_FROM_JMS (JMS64I) 0x0000000000000001

/*!
  This flag indicates that the JMS subsystem should not free the input handle
  when the callback function returns.  If this flag is set then it
  is the responsiblity of the application to free the handle that
  is passed into the callback function
  */
#define JMS_APPLICATION_MUST_FREE_HANDLE (JMS64I) 0x0000000000000002

/*!
  Indicates that a given string input or output is a NULL terminated UTF-8 encoded
  string
  */
#define CSTRING 0

/*!
  Indicates that given input or output is a two-byte per character java string
  */
#define UNISTRING 1

/*! Used to represent java strings or C STRING
\par When used for input to a function
When used as input, stringType must be set to CSTRING or UNISTRING.  If stringType is CSTRING,
then uniOrC.string should point to the UTF-8 encoded NULL-terminated C string.  If stringType
is UNISTRING then uniOrC.uniString.data should point to the multi-byte string (possibly with
embedded NULL characters) and uniOrC.uniString.length should contain the amount of data
in bytes.  (So, for example if the string is a three character two-byte java string, length should
contain six)
\par When used as output from a function
When used as output, stringType must be set to CSTRING if the output should be represented
as a UTF-8 encoded NULL-terminated C string or UNISTRING if the output should be represented
as a two-byte character java string.  If uniOrC.string (which also corresponds to uniOrC.uniString.data)
is NULL, then the function will allocate memory for the output with malloc().  It is the responsibility
of the caller of the function to later call free() on this memory.  If uniOrC.string is not-NULL, then
the amount of data available to be written into must be put into the allocatedSize member
variable.  If there is not enough space, the function will return JMS_NEED_SPACE and the amount
of space needed will be placed in allocatedSize.  In this case the function will have filled in as
much of the data as possible.
*/
typedef struct {
  /*! The type of string represented on input or the type requested on output */
  int stringType;
  /*! Describes either a C string or multi-byte string */
  union {
    /*! A NULL terminated UTF-8 encoded C string */
    char *string;
    /*! Represents a muti-byte string */
    struct {
      /*! The data portion of the string */
      void *data;
      /*! The size of data in bytes */
      JMS32I length;
    } uniString;
  } uniOrC;
  /*! Should be set to the size of the data available for output */
  int allocatedSize; 
} JmsString;

#endif /* _JMSCOMMON_H */

