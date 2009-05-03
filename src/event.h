/*
 * See Licensing and Copyright notice in naev.h
 */


#ifndef EVENT_H
#  define EVENT_H


/**
 * @brief Possibly event triggers.
 */
typedef enum EventTrigger_s {
   EVENT_TRIGGER_NULL, /**< Invalid trigger. */
   EVENT_TRIGGER_ENTER /**< Entering a system (jump/takeoff). */
} EventTrigger_t;


/*
 * Loading/exitting.
 */
int events_load (void);
void events_exit (void);


/*
 * Triggering.
 */
void events_trigger( int where );


#endif /* EVENT_H */


