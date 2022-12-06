/*! \file JmsEnumeration.h
    \brief Describes a JmsEnumeration handle
    
    This file describes the functions that can be performed on a JmsEnumeration handle
    A JmsDestination handle corresponds to java.util.Enumeration
    \author Copyright (c) 2002, BEA Systems, Inc.
*/

#ifndef _JMS_ENUMERATION_H
#define _JMS_ENUMERATION_H 1

/*!
  A enumeration handle that represents the class java.util.Enumeration
  */
typedef struct JmsEnumeration JmsEnumeration;

#include <JmsCommon.h>
#include <JmsTypes.h>

#ifdef __cplusplus
extern "C" {
#endif /* __cplusplus */

/*!
  Tells if the given enumeration handle has another element
  \param enumeration Must be a valid enumeration handle.  May not be NULL
  \param more May not be NULL.  On success, *more will be set to zero if
  there are no more element, and non-zero if there are more elements
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
    - JMS_NEED_SPACE
  */
extern int JMSENTRY JmsEnumerationHasMoreElements(
  JmsEnumeration  * enumeration,
  int            * more,
  JMS64I              flags
);

/*!
  Gets the next element from the enumeration
  An enumeration can come from several sources, so type of
  the second parameter will be determined by the origin of
  the enumeration itself.  For example, in some cases **message
  should be a JmsMessage **, while in other cases **message
  should be a JmsString **
  \param enumeration Must be a valid enumeration handle.  May not be NULL
  \param message Must not be NULL.  On success *message will contain the
  appropriate output handle or type for the enumeration
  a valid destination handle
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
    - JMS_NEED_SPACE
  */
extern int JMSENTRY JmsEnumerationNextElement(
  JmsEnumeration  * enumeration,
  void       ** message,
  JMS64I              flags
);

/*!
  Destroys the enumeration.  After a call to this function the enumeration
  handle is no longer valid and should not be referenced
  \param enumeration Must be a valid enumeration handle.  May not be NULL
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
    - JMS_NEED_SPACE
  */
extern int JMSENTRY JmsEnumerationDestroy(
    JmsEnumeration *enumeration,
    JMS64I              flags
);
    
#ifdef __cplusplus
}
#endif /* __cplusplus */
#endif /* _JMS_ENUMERATION_H */

