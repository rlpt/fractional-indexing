const fi = require("./expirement.js");

describe("experiment", () => {
    // test("getIntegerLength", () => {
    //     try {
    //         expect(fi.getIntegerLength("a")).toBe(2); 
    //         expect(fi.getIntegerLength("d")).toBe(5); 
    //         expect(fi.getIntegerLength("z")).toBe(27); 
    //         expect(fi.getIntegerLength("A")).toBe(27); 
    //         expect(fi.getIntegerLength("D")).toBe(24); 
    //         expect(fi.getIntegerLength("Z")).toBe(2); 
    //     } catch (e) {
    //         console.log(e)
    //     }
    // })
    
    // test("getIntegerPart", () => {
    //     try {
    //         expect(fi.getIntegerPart("a0")).toBe("a0"); 
    //         expect(fi.getIntegerPart("Zz")).toBe("Zz"); 
    //         expect(fi.getIntegerPart("a0V")).toBe("a0"); 
    //         expect(fi.getIntegerPart("b125")).toBe("b12"); 
    //     } catch (e) {
    //         console.log(e)
    //     }
    // })
    
    // test("validateInteger", () => {
    //     console.log(fi.validateInteger("Zz"))   
    // })

    // test("incrementInteger", () => {
    //     console.log(fi.incrementInteger("a0", fi.BASE_62_DIGITS))  // a1 
    //     console.log(fi.incrementInteger("bzz", fi.BASE_62_DIGITS))  // bz0 
    //     console.log(fi.incrementInteger("Zz", fi.BASE_62_DIGITS))  // Z0 
    // })
    
    test("inc", () => {
        console.log(fi.inc("by", fi.BASE_62_DIGITS))  // a1 
        // console.log(fi.incrementInteger("bzz", fi.BASE_62_DIGITS))  // bz0 
        // console.log(fi.incrementInteger("Zz", fi.BASE_62_DIGITS))  // Z0 
    })

    // test("validateOrderKey", () => {
    //     // expect(() => fi.validateOrderKey("A00000000000000000000000000", fi.BASE_62_DIGITS))
    //     //     .toThrow( "invalid order key: A00000000000000000000000000"); 
        
    //     // expect(() => fi.validateOrderKey("a00", fi.BASE_62_DIGITS))
    //     //     .toThrow( "invalid order key: a00"); 
        
    //         expect(() => fi.validateOrderKey("a0", fi.BASE_62_DIGITS))
    //         .toThrow( "invalid order key: a0"); 
    // })
})
