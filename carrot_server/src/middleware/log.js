exports.logRequestTime = (req, res, next) => {
    const start = Date.now();
    res.on('finish', () => {
        const duration = Date.now() - start;
        console.log(`Request to ${req.originalUrl} took ${duration}ms`);
        console.log('${req.method} ${req.originalUrl} - ${duration}ms');
    });
    next();
}   