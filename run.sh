#!/bin/bash -e
rm -f allocs
args="-fforce-recomp"
get_allocs() { tail -n1 $1 | cut -d' ' -f2; }
for i in 10 100 500 1000 5000 10000; do
    python test.py $i >| test.hs
    echo $i;
    ghc -c test.hs -O0 $args +RTS -s -t >| with-o0-$i 2>&1; size test.o
    ghc -c test.hs -O1 $args +RTS -s -t >| with-o1-$i 2>&1; size test.o
    ghc -c test.hs -O2 $args +RTS -s -t >| with-o2-$i 2>&1; size test.o
    tail -n1 with-o0-$i | cut -f1
    tail -n1 with-o1-$i | cut -f1
    tail -n1 with-o2-$i | cut -f1
    
    printf "%d\t%d\t%d\t%d\n" $i $(get_allocs with-o0-$i) $(get_allocs with-o1-$i) $(get_allocs with-o2-$i) >> allocs
done;
echo allocations; cat allocs
