String Ref Counted
WRITE A STRING CLASS THAT DOES COPY-ON-WRITE
I only give this question to veteran C++ programmers. This is a tough one to frustrate interviewees. However, just like any tough questions I give, I always prepare multiple level of hints, so that we can guide them to right directions when time is running out. We want to find out how they approach and solve a problem, more than the final answer.
Question: write a string class that does copy-on-write. So, this piece of code is efficient enough without any string copying:

```
cowstring a = "test";
cowstring b = a; // no strcpy or memcpy internally!
a = "test1"; // still no copying, but a is changed with b still being "test".
```
A couple of things to test:
1. Understanding of the question. If someone is confused by the question, we don't really have a hard-core C++ programmer.
2. Understanding the challenge. If someone is jumping into coding immediately, either (a) he/she has seen the problem before (then skip); or (b) he/she will probably take a wrong approach. The real challenge is, there has to be some reference counting controlling the string data separately from the "cowstring" class we will write.
I normally look for someone who thinks for a moment, and describes the real challenge to me. Otherwise, I will always stop an immediate-coder with a question "wait, how are you going to do it?". We want people who can describe their ideas clearly, as that's just a good indication of clear mind. When I find out he/she is about to take a wrong approach, I normally give out the hint "reference counting", after explaining why their approach won't work well by giving them counter coding examples. This is really a good interactive process that I want to see my candidate listening, communicating and understanding.
Now that the algorithm is finalized, I'll ask for an implementation of reference counting. Here's one,
class _cow_string_data {
  public:
    _cow_string_data(const char *str) : m_str(NULL), m_ref(1) {
      if (str) m_str = strdup(str);
    }
    ~_cow_string_data() {
      if (m_str) free(m_str);
    }

    void inc() { m_ref++;}
    void dec() { if (--m_ref == 0) delete this;}

  private:
    char *m_str;
    int m_ref;
 };

 class cowstring {
  public:
    cowstring(const char *s) {
      m_data = new _cow_string_data(s);
    }

    cowstring(const cowstring &s) : m_data(s.m_data) {
      m_data->inc();
    }

    ~cowstring() {
      m_data->dec();
    }

    cowstring &operator=(const cowstring &s) {
      if (&s != this) {
         m_data->dec();
         m_data = s.m_data;
         m_data->inc();
      }
      return *this;
    }

  private:
    _cow_string_data *m_data;
 };
Notes:
1. Syntax of constructors and operator overloading can all be given out with no penalty, but if someone can write it without hints, it's a plus about knowing C++ really well.
2. Correctly and concisely incrementing and decrementing reference counts is what we are testing about. Expect completely different coding and style from different people.
3. Finding coding errors is interviewer's job. Don't directly point it out. Instead, find a coding example that will fail, and give that to see if interviewee can figure out where the problem is. This interactive debugging is really a good way during a coding interview for almost any question.
4. That "if (*s != this)" is something that's bonus for star players.
5. Make sure there is no memory problems, either.