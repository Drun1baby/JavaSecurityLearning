/*! \file JmsConnectionFactory.h
    \brief Describes a JmsConnectionFactory handle
    \author Copyright (c) 2002, BEA Systems, Inc.
    This file describes the functions that can be performed on a JmsConnectionFactory handle
    A JmsConnectionFactory handle corresponds to javax.jms.ConnectionFactory
*/
#ifndef _JMS_CONNECTION_FACTORY_H
#define _JMS_CONNECTION_FACTORY_H 1

#include <JmsCommon.h>
#include <JmsContext.h>
#include <JmsTypes.h>

/*!
  A connection factory handle that represents the class javax.jms.ConnectionFactory
  */
typedef struct JmsConnectionFactory JmsConnectionFactory;

#ifdef __cplusplus
extern "C" {
#endif /* __cplusplus */

/*!
  Gets a connection factory handle from a context handle
  \param aContext Must be a valid context handle.  May not be NULL
  \param connectionFactoryName Contains the JNDI name of the connection
  factory to create.  May not be NULL.
  \param connectionFactory May not be NULL.  On success *connectionFactory will contain a
    valid JmsConnectionFactory handle
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsContextCreateConnectionFactory(
  JmsContext *aContext,
  JmsString *connectionFactoryName,
  JmsConnectionFactory **connectionFactory,
  JMS64I              flags
);

/*!
  Destroys a connection factory handle.  After a call to this function the connectionFactory
  handle has been destroyed and should no longer be referenced
  \param connectionFactory Must be a valid connection factory handle.  May not be NULL
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsConnectionFactoryDestroy(
  JmsConnectionFactory *connectionFactory,
  JMS64I              flags
);

#ifdef __cplusplus
}
#endif /* __cplusplus */
#endif /* _JMS_CONNECTION_FACTORY_H */
