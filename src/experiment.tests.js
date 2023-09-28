const fi = require("./expirement.js");

describe("experiment", () => {
    test("getIntegerLength", () => {
        try {
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
    
    test("getIntegerPart", () => {
        try {
            // expect(fi.getIntegerPart("a0")).toBe(2); 
            console.log("a0", fi.getIntegerPart("a0")); 
            console.log("Zz", fi.getIntegerPart("Zz")); 
            console.log("a0V", fi.getIntegerPart("a0V")); 
            console.log("b125", fi.getIntegerPart("b125")); 
        } catch (e) {
            console.log(e)
        }
    })
})