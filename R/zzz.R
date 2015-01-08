pkgconfig <-
    function(opt = c("PKG_CFLAGS", "PKG_LIBS"))
{
    path <- system.file("lib", package="Rhtslib", mustWork=TRUE)
    if (nzchar(.Platform$r_arch)) {
        arch <- sprintf("/%s", .Platform$r_arch)
    } else {
        arch <- ""
    }
    patharch <- paste0(path, arch)

    result <- switch(match.arg(opt), PKG_CFLAGS={
        sprintf('-I"%s"', system.file("include", package="Rhtslib"))
    }, PKG_LIBS={
        if(Sys.info()['sysname'] == "Linux") ## -rpath needed for Linux
            sprintf('-L"%s" -Wl,-rpath,"%s" -lhts -lz', patharch, patharch)
        else
            sprintf('-L"%s" -lhts -lz', patharch)
    })

    cat(result)
}

.onAttach <-
    function(...)
{
    vers <- .Call("Rhtslib_htslib_version", PACKAGE="Rhtslib")
    packageStartupMessage("Rhtslib htslib version ", vers)
}
