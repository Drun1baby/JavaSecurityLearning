/*! \file JmsContext.h
    \brief Describes a JmsConsumer handle
    
    This file describes the functions that can be performed on a JmsConsumer handle
    A JmsContext handle is used to get access to the JMS provider
    \author Copyright (c) 2002, BEA Systems, Inc.
*/

#ifndef _JMS_CONTEXT_H
#define _JMS_CONTEXT_H 1

#include <JmsCommon.h>

/*!
  A context handle that is used to get access to the JMS provider
  */
typedef struct JmsContext JmsContext;

#ifdef __cplusplus
extern "C" {
#endif /* __cplusplus */

/*!
  Gets a context handle with the given properties
  \param uri The URI of the JMS provider instance.  If NULL, this defaults
  to "t3://localhost:7001"
  \param jndiFactory The name of the jndi factory to use in order to get the initial
  context.  If NULL, defaults to "weblogic.jndi.WLInitialContextFactory"
  \param username The name to use when logging in to the JMS provider
  \param password The password to use as authentication material
  \param context May not be NULL.  On success *context will point to a valid
  context handle
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsContextCreate(
  JmsString      * uri,
  JmsString      *jndiFactory,
  JmsString      * username,
  JmsString      * password,
  JmsContext ** context,
  JMS64I              flags
);

/*!
  Destroys a context handle
  \param context Must be a valid context handle.  May not be NULL
  \param flags Reserved for future use.  Must be zero
  */
extern int JMSENTRY JmsContextDestroy(
  JmsContext  * context,
  JMS64I              flags
);

#ifdef __cplusplus
}
#endif /* __cplusplus */
#endif /* _JMS_CONTEXT_H */
