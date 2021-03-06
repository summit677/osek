/* OSEKOS Implementation of an OSEK Scheduler
 * Copyright (C) 2015 Joakim Plate
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.

 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.

 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
 */

/**
 * @file
 * @ingroup Os
 */

#ifndef OS_TYPES_H_
#define OS_TYPES_H_

#include "Std_Types.h"

typedef uint8 Os_TaskType;        /**< task identifier */
typedef uint8 Os_ResourceType;    /**< resource identifier */
typedef sint8 Os_PriorityType;    /**< priority level */

typedef uint8 Os_StatusType;      /**< return value for os functions */

typedef uint8  Os_AlarmType;      /**< alarm identifier */
typedef uint8  Os_CounterType;    /**< counter identifer */
typedef uint16 Os_TickType;       /**< tick value identifier */

#define OS_MAXALLOWEDVALUE UINT8_MAX

#define OS_INVALID_TASK      (Os_TaskType)(-1)
#define OS_INVALID_RESOURCE  (Os_ResourceType)(-1)
#define OS_INVALID_ALARM     (Os_AlarmType)(-1)
#define OS_INVALID_COUNTER   (Os_CounterType)(-1)

#define OS_CONFORMANCE_BCC1 0u
#define OS_CONFORMANCE_BCC2 1u
#define OS_CONFORMANCE_ECC1 2u
#define OS_CONFORMANCE_ECC2 3u

/**
 * @brief Current call context
 */
typedef enum Os_ContextType {
    OS_CONTEXT_NONE  = 0,         /**< OS_CONTEXT_NONE - Os has not been started */
    OS_CONTEXT_TASK  = 1,         /**< OS_CONTEXT_TASK - Os currently called from a task */
    OS_CONTEXT_ISR1  = 2,         /**< OS_CONTEXT_ISR1 - Os currently called from interrupt category 1 */
    OS_CONTEXT_ISR2  = 3,         /**< OS_CONTEXT_ISR2 - Os currently called from interrupt category 2 */
} __attribute__ ((__packed__)) Os_ContextType;

/**
 * @brief State of a task
 */
typedef enum Os_TaskStateEnum {
    OS_TASK_SUSPENDED   = 0,        /**< OS_TASK_SUSPENDED */
    OS_TASK_READY       = 1,        /**< OS_TASK_READY */
    OS_TASK_WAITING     = 2,        /**< OS_TASK_WAITING */
    OS_TASK_RUNNING     = 3,        /**< OS_TASK_RUNNING */
    OS_TASK_READY_FIRST = 4,        /**< OS_TASK_READY_FIRST */
} __attribute__ ((__packed__)) Os_TaskStateEnum;

#define OS_RES_SCHEDULER (Os_ResourceType)0

typedef void          (*Os_TaskEntryType)(void); /**< type for the entry point of a task */

#define E_OS_ACCESS   (Os_StatusType)1
#define E_OS_CALLEVEL (Os_StatusType)2
#define E_OS_ID       (Os_StatusType)3
#define E_OS_LIMIT    (Os_StatusType)4
#define E_OS_NOFUNC   (Os_StatusType)5
#define E_OS_RESOURCE (Os_StatusType)6
#define E_OS_STATE    (Os_StatusType)7
#define E_OS_VALUE    (Os_StatusType)8

#define E_OS_SYS_NOT_IMPLEMENTED (Os_StatusType)16

#endif /* OS_TYPES_H_ */
