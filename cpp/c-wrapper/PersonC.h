#ifndef __PERSONC_H
#define __PERSONC_H

#ifdef __cplusplus
extern "C" {
#endif

typedef struct Person Person;

Person* newPerson(const char* name);
void setPersonName(Person* v, const char* name);
const char* getPersonName(Person* v);
void deletePerson(Person* v);

#ifdef __cplusplus
}
#endif
#endif