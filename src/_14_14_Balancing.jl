#!/usr/bin/env julia
#GSL Julia wrapper
#(c) 2013 Jiahao Chen <jiahao@mit.edu>
###################
# 14.14 Balancing #
###################
export linalg_balance_matrix




# This function replaces the matrix A with its balanced counterpart and stores
# the diagonal elements of the similarity transformation into the vector D.
# 
#   Returns: Cint
function linalg_balance_matrix()
    A = convert(Ptr{gsl_matrix}, Array(gsl_matrix, 1))
    D = convert(Ptr{gsl_vector}, Array(gsl_vector, 1))
    errno = ccall( (:gsl_linalg_balance_matrix, :libgsl), Cint,
        (Ptr{gsl_matrix}, Ptr{gsl_vector}), A, D )
    if errno!= 0 throw(GSL_ERROR(errno)) end
    return unsafe_ref(A) ,unsafe_ref(D)
end
