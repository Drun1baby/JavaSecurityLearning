/*! \file JmsDestination.h
    \brief Describes a JmsDestination handle
    
    This file describes the functions that can be performed on a JmsDestination handle
    A JmsDestination handle corresponds to javax.jms.Destination
    \author Copyright (c) 2002, BEA Systems, Inc.
*/

#ifndef _JMS_DESTINATION_H
#define _JMS_DESTINATION_H 1

#include <JmsCommon.h>
#include <JmsContext.h>
#include <JmsTypes.h>

/*!
  A destination handle that represents the class javax.jms.Destination
  */
typedef struct JmsDestination JmsDestination;

#ifdef __cplusplus
extern "C" {
#endif /* __cplusplus */

/*!
  Gets a destination handle from the given context with the given name
  \param context Must be a valid context handle.  May not be NULL
  \param name The JNDI name of the destination to create.  May not be NULL
  \param destination May not be NULL. On success, *destination will contain
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
extern int JMSENTRY JmsDestinationCreate(
  JmsContext *context,
  JmsString *name,
  JmsDestination **destination,
  JMS64I              flags
);

/*!
  Destroys a destination handle
  \param destination Must be a valid destination handle.  May not be NULL
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
    - JMS_NEED_SPACE
  */
extern int JMSENTRY JmsDestinationDestroy(
    JmsDestination *destination,
    JMS64I              flags
 );

#ifdef __cplusplus
}
#endif /* __cplusplus */
#endif /* _JMS_DESTINATION_H */
