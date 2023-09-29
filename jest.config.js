module.exports = {
    // The root of your source code, typically /src
    roots: ["<rootDir>/src"],

    // Test spec file resolution pattern
    // By default it looks for .js, .jsx, .ts and .tsx files inside __tests__ folders and on any file with a .spec or .test suffix
    // testRegex: '(/__tests__/.*|(\\.|/)(test|spec))\\.tsx?$',
    testMatch: ["**/?(*.)tests.js"],

    // Module file extensions for importing
    moduleFileExtensions: ["ts", "tsx", "js", "jsx", "json", "node", "mjs"],
};
