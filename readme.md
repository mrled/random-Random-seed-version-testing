# Python random.Random .seed() method with version=1 does not reproduce Python 2.7 behavior

When using the `random.Random` class, using the `.seed()` method with `version=1` and then calling `.randrange()` does not always reproduce the same results as the `.seed()` method did in Python 2.

From the docs, I did expect it to match Python 2, but on closer inspection, I can't tell whether I made a bad assumption or whether there is a bug in the module.

The docs state an intention of compatibility with older versions of Python:
https://docs.python.org/3.9/library/random.html#notes-on-reproducibility

> Most of the random module’s algorithms and seeding functions are subject to change across Python versions, but two aspects are guaranteed not to change:
>
> - If a new seeding method is added, then a backward compatible seeder will be offered.
> - The generator’s random() method will continue to produce the same sequence when the compatible seeder is given the same seed.

It's not clear from the docstring in the code whether this is intended to cover Python 2.7 behavior:
https://github.com/python/cpython/blob/3.9/Lib/random.py#L134

> For version 2 (the default), all of the bits are used if *a* is a str,
> bytes, or bytearray.  For version 1 (provided for reproducing random
> sequences from older versions of Python), the algorithm for str and
> bytes generates a narrower range of seeds.

But the results I've spot checked sometimes do match the Python 2 results, and sometimes are the Python 2 result +1.

I've included the following in this repo:

1. A python script that calls the `.seed()` method with `version=1` under Python 3, and without a version= argument under Python 2, and then `.randrange(0, 65535, 1)`. It uses as a seed every word in a wordlist I happened to have in /usr/share/dict.
1. A shell script that runs the script with the Python versions I happen to have installed locally, along with Python 2.7 and 3.4-3.9 in the ci-image Docker container linked from the Python download page.
1. The results from each Python version

I ran the script on my Mac, which means I used the system installed Python binaries that came with macOS x86_64, but the ci-image Python versions are running under an x86_64 Linux virtual machine (because of how Docker for Mac works).
 
To summarize the results:

* The Python 2.7 on my Mac works the same as the Python 2.7 on the ci-image
* The Python 3.8 on my Mac works the same as Pythons 3.5-3.9 on the ci-image
* Python 3.4 is different from both (although it is now unsupported anyway)

A sample of the results. I haven't programmatically analyzed them, but from my spot checks, they all appear to be like this. The middle column compares the output based on the input.

```sh
> head results.ci-image.python2.7     > head results.ci-image.python3.9
A: 8866                            <  A: 8867
a: 56458                           <  a: 56459
aa: 29724                          =  aa: 29724
aal: 11248                         =  aal: 11248
aalii: 16623                       =  aalii: 16623
aam: 62302                         <  aam: 62303
Aani: 31381                        =  Aani: 31381
aardvark: 6397                     =  aardvark: 6397
aardwolf: 32525                    <  aardwolf: 32526
Aaron: 32019                       =  Aaron: 32019
```
