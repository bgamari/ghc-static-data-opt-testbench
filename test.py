import sys
n = int(sys.argv[1])
print """
{-# LANGUAGE MagicHash #-}
module Test where
import GHC.Exts
data T = T Addr# Int# Int
"""
for i in range(n):
    print """t%d = T "%010d"# %d# %d""" % (i, i, i, 2*i)

