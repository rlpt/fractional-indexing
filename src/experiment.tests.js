const fi = require("./expirement.js");

describe("experiment", () => {
    test("getIntegerLength", () => {
        try {
            // console.log(fi.getIntegerPart("a0"), fi.BASE_62_DIGITS)
            expect(fi.getIntegerLength("a")).toBe(2); 
            expect(fi.getIntegerLength("d")).toBe(5); 
            expect(fi.getIntegerLength("z")).toBe(27); 
            expect(fi.getIntegerLength("A")).toBe(27); 
            expect(fi.getIntegerLength("D")).toBe(24); 
            expect(fi.getIntegerLength("Z")).toBe(2); 
        } catch (e) {
            console.log(e)
        }
    })
})