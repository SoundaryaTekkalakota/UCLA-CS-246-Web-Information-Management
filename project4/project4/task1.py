#!/usr/bin/env python3

import sys
import os
import numpy
import numpy.linalg
import scipy.misc

def getOutputPngName(path, rank):
    filename, ext = os.path.splitext(path)
    return filename + '.' + str(rank) + '.png'

def getOutputNpyName(path, rank):
    filename, ext = os.path.splitext(path)
    return filename + '.' + str(rank) + '.npy'

if len(sys.argv) < 3:
    sys.exit('usage: task1.py <PNG inputFile> <rank>')

inputfile = sys.argv[1]
rank = int(sys.argv[2])
outputpng = getOutputPngName(inputfile, rank)
outputnpy = getOutputNpyName(inputfile, rank)

#
# TODO: The current code just prints out what it is supposed to to
#       Replace the print statement wth your code
#
#print("This program should read %s file, perform rank %d approximation, and save the results in %s and %s files." % (inputfile, rank, outputpng, outputnpy))

#load image
image = scipy.misc.imread(inputfile, 0)

# Perform SVD
U, s, V = numpy.linalg.svd(image)

# Keep only top-k entries
U_k = U[:,:rank]
V_k = V[:rank,:]
s_k = s[:rank]

# Diagonalize s(array) into a (rank x rank) matrix
s_k_diag = numpy.diag(s_k)
result = numpy.dot(U_k, numpy.dot(s_k_diag, V_k))

# save binary array file to outputnpy
numpy.save(outputnpy, result)
# save png file to outputpng
scipy.misc.imsave(outputpng, result)
