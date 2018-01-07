
#ifndef SET_DEFINED
#define SET_DEFINED


typedef struct _set_data {
  void * data;
  struct _set_data * next;
} SetData;


typedef struct _set_structure {
  
  int (*add)(struct _set_structure *, void *);
  int (*has)(struct _set_structure *, void *);
  int (*delete)(struct _set_structure *, void *);
  int (*size)(struct _set_structure *);
  int (*clear)();
  
  struct _set_structure * (*intersect)(struct _set_structure *, struct _set_structure *);
  struct _set_structure * (*unify)(struct _set_structure);
  
  struct _set_structure * self;
  // (void) will be a function, pass in arguments
  void (*forEach)(void);

  SetData * curdata;
  
  int length;
} Set;


extern Set * NewSet( void *  );

extern int add ( Set * , void * );
extern int has ( Set * , void * );
extern int delete ( Set * , void * );
extern int size ( Set * );
extern Set * intersect(Set * , Set *);
#endif
