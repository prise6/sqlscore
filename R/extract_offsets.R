# Standardized offset extraction
# 
# Extract model offsets (if present) in a standardized format. The return value is a numeric vector
# with formula terms as names and values all 1.
# 
# @param object An object for which the extraction of model offsets is meaningful.
# 
# @return Model offsets as a numeric vector with all values 1 and formula terms as names.
extract_offsets <-
function(object)
{
  UseMethod("extract_offsets")
}

#' @export
extract_offsets.default <-
function(object)
{
  if("formula" %in% names(object))
  {
    fm <- object$formula
  } else if("call" %in% names(object) &&
            "formula" %in% names(as.list(object$call)))
  {
    fm <- as.list(object$call)$formula
  } else
  {
    return(c())
  }
  
  pos <- attr(stats::terms(object), "offset")
  if(!is.null(pos))
  {
    ret <- rep(1, length(pos))
    names(ret) <- all.vars(fm)[pos]
    
    return(ret)
  } else
  {
    return(c())
  }
}

#' @export
extract_offsets.glmboost <-
function(object)
{
  #mboost doesn't support this
  c()
}

#' @export
extract_offsets.cv.glmnet <-
function(object)
{
  #glmnet doesn't support this either
  c()
}
