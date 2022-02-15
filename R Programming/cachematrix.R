## Put comments here that give an overall description of what your
## functions do

## Write a short comment describing this function
## makeCacheMatrix define functions of get & store (set) the value of input matrix
## and get & store (set) the calculated inverse matrix (of the input matrix)

makeCacheMatrix <- function(x = matrix()) {
  result <- NULL
  ## define get and set function
  get <- function() x

  set <- function(y) {
    x <<- y
    result <<- NULL
  }

  ## define the get and set function for calculated inverse matrix
  getInversedMatrix <- function() result

  setInversedMatrix <- function(solve) result <<- solve

  # create the list of functions
  list(get = get, set = set, getInversedMatrix = getInversedMatrix, setInversedMatrix = setInversedMatrix)
}


## Write a short comment describing this function
## Function `cacheSolve` will return the value of the inverse of the matrix
## It firstly check whether the inverse has been calculated by assert the stored value by Function `makeCacheMatrix`
## If it's calculated, it directly return the cached result
## If not, it will calculate, store the result and return it

cacheSolve <- function(x, ...) {
  result <- x$getInversedMatrix()

  ## check whether this inverse has been calculated
  ## If so, directly return it
  if (!is.null(result)) {
    message("The inverse matrix of this input has already calculated. Here return the cached result")
    return(result)
  }

  ## Calculate the inverse matrix
  inputMatrix <- x$get()
  result <- solve(inputMatrix, ...)

  ## Return a matrix that is the inverse of 'x'
  x$setInversedMatrix(result)
  result
}
