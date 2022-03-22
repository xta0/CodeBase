struct SomeStruct {
  double dbl; // Added to make it more clear how offsets are handled by
              // giving x a nonzero offset.
  int x;
  int y;
};

int accessMember(struct SomeStruct *o)
{
  return o->x + o->y;
}

int accessArray(int o[4]) {
  return o[2] + o[3];
}