#!/usr/bin/env julia
#GSL Julia wrapper
#(c) 2013 Jiahao Chen <jiahao@mit.edu>
#######################################
# 22.17 Searching 2D histogram ranges #
#######################################
export histogram2d_find


# This function finds and sets the indices i and j to the to the bin which
# covers the coordinates (x,y). The bin is located using a binary search.  The
# search includes an optimization for histograms with uniform ranges, and will
# return the correct bin immediately in this case. If (x,y) is found then the
# function sets the indices (i,j) and returns GSL_SUCCESS.  If (x,y) lies
# outside the valid range of the histogram then the function returns GSL_EDOM
# and the error handler is invoked.
# 
#   Returns: Cint
function histogram2d_find(h::Ref{gsl_histogram2d}, x::Real, y::Real)
    i = Ref{Csize_t}()
    j = Ref{Csize_t}()
    errno = ccall( (:gsl_histogram2d_find, libgsl), Cint,
        (Ref{gsl_histogram2d}, Cdouble, Cdouble, Ref{Csize_t}, Ref{Csize_t}),
        h, x, y, i, j )
    if errno!= 0 throw(GSL_ERROR(errno)) end
    return i[], j[]
end
