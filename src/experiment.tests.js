const fi = require("./expirement.js");

console.log(fi);

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

    const BASE_62_DIGITS = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";

    /**
     * @param {string | null} a
     * @param {string | null} b
     * @param {number} n
     * @param {string} exp
     */
    function testN(a, b, n, exp) {
        /** @type {string} */
        let act;
        try {
            act = fi.generateNKeysBetween(a, b, n, BASE_62_DIGITS).join(" ");
        } catch (exp) {
            act = exp.message;
        }

        console.assert(exp == act, `${exp} == ${act}`);
    }

    test("nb", () => {
        // testN("a4", null, 10, "a5 a6 a7 a8 a9 b00 b01 b02 b03 b04");
    })

    // testN(null, null, 5, "a0 a1 a2 a3 a4");
    // testN("a4", null, 10, "a5 a6 a7 a8 a9 b00 b01 b02 b03 b04");

    // test("incrementInteger", () => {
    //     console.log(fi.incrementInteger("bzz", fi.BASE_62_DIGITS)) 
    // })
    

    // test("validateOrderKey", () => {
    //     // expect(() => fi.validateOrderKey("A00000000000000000000000000", fi.BASE_62_DIGITS))
    //     //     .toThrow( "invalid order key: A00000000000000000000000000"); 
        
    //     // expect(() => fi.validateOrderKey("a00", fi.BASE_62_DIGITS))
    //     //     .toThrow( "invalid order key: a00"); 
        
    //         expect(() => fi.validateOrderKey("a0", fi.BASE_62_DIGITS))
    //         .toThrow( "invalid order key: a0"); 
    // })
})
