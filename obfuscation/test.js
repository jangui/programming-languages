//https://mrpapercut.com/blog/2016-09-06-non-alphanum-obfuscator
_ = ~[];
_ = {
    a: {
        a: !![]+[], // "true"
        b: ![]+[],  // "false"
        c: []+{},   // "[object Object]"
        d: [][_]+[] // "undefined"
    },
    b: ++_,         // 0
    c: ++_,         // 1
    d: -~_++,       // 2
    e: -~_,         // 3
    f: -~++_        // 4
}
