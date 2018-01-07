#include <stdarg.h>
#include <stdlib.h>
#include "set.h"



Set * NewSet(void * data) {
  
  Set * newDataToSet = malloc(sizeof(Set));

  if ( ! newDataToSet )
    return NULL ;
  
  newDataToSet->curdata = malloc(sizeof(SetData));
  
  newDataToSet->curdata->data = data;

  newDataToSet->add = add;
  newDataToSet->has = has;
  newDataToSet->delete = delete;
  newDataToSet->size = size;
  newDataToSet->intersect = intersect;
  
  newDataToSet->length = 1;
  
  newDataToSet->self = newDataToSet;
  
  return newDataToSet;
}

// modify add so that you use this
//   instead of Set * addToSet as argument



int add(Set * addToSet, void * data) {;
}


int has(Set * checkOccurence, void * data) {
  
  if ( ! checkOccurence )
    return -1;

  if ( checkOccurence->curdata->data == data )
    return 1;

  int result = 0;
  
  while ( checkOccurence->curdata->next != NULL ) {
    if ( checkOccurence->curdata->next->data == data ) {
      result = 1;
      break;
    }
    checkOccurence->curdata = checkOccurence->curdata->next;
  }

  if ( result == 0 )
    return 0;

  return 1;
}

int delete(Set * deleteSet, void * data) {
  
  if ( ! deleteSet )
    return -1;
  
  if ( deleteSet->has(deleteSet, data) ) {
    
    free(deleteSet->curdata);
    free(deleteSet);
    
    return 1;
  }
  
  return 0;
}


int size(Set * checkSize) {

  if( ! checkSize )
    return -1;

  return checkSize->length;
}

Set * intersect(Set * firstset, Set * secondset) {
  
  /* if ( ! firstset || ! secondset ) */
  /*   return NULL; */


  /* Set * intersectData = NewSet("hi"); */

  /* if ( ! intersectData ) */
  /*   return NULL; */

  /* SetData * firstData = malloc(sizeof(SetData)); */
  /* SetData * secondData = malloc(sizeof(SetData)); */

  /* if ( ! firstData || ! secondData ) */
  /*   return NULL; */
  
  /* firstData = firstset->curdata; */
  /* secondData = secondset->curdata; */
  
  /* while ( firstData != NULL ) { */
    
  /*   /\* while ( secondData != NULL ) { *\/ */
  /*   /\*   if ( firstData->data == secondData->data ) { *\/ */
  /*   /\*     intersectData->add(intersectData, firstData->data); *\/ */
  /*   /\*   } *\/ */
  /*   /\*   secondData = secondData->next; *\/ */
      
  /*   /\* } *\/ */

  /*   //printf("%d\n", firstData->data); */
    
  /*   firstData = firstData->next; */
  /* } */

  /* while ( firstset->curdata->next ) { */
  /*   //printf("%d\n", firstset->curdata->next->data); */
  /*   firstset->curdata->next = firstset->curdata->next->next; */
  /* } */

  /* return intersectData; */
  
}

void viewAll(Set *aa) {
  while ( aa->curdata != NULL ) {
    printf("%d\n", aa->curdata->data);
    aa->curdata = aa->curdata->next;
  }
};

